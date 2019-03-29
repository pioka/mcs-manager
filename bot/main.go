package main

import (
	"flag"
	"fmt"
	"os"
	"os/exec"
	"os/signal"
	"strings"

	"github.com/bwmarrin/discordgo"
)

var (
	Token   string
	OwnerID string
)

func main() {
	// Get Commandline args
	flag.Parse()
	args := flag.Args()
	if len(args) < 2 {
		fmt.Println("Usage: mcs-bot <BotToken> <ServerOwnerID>")
		return
	}
	Token = args[0]
	OwnerID = args[1]

	// Create session
	dg, err := discordgo.New("Bot " + Token)
	if err != nil {
		fmt.Println("ERROR Cannnot create Discord session", err)
		return
	}

	dg.AddHandler(responseCommand)

	// Open socket
	err = dg.Open()
	if err != nil {
		fmt.Println("ERROR Cannot open Websocket connection")
		return
	}

	// Waiting Interrupt
	fmt.Println("Bot is ready. Press Ctrl-C to exit.")
	sc := make(chan os.Signal, 1)
	signal.Notify(sc, os.Interrupt)
	<-sc

	dg.Close()
}

func responseCommand(session *discordgo.Session, msg *discordgo.MessageCreate) {
	var sendText string
	var command string

	if msg.Author.ID == session.State.User.ID || !strings.HasPrefix(msg.Content, "!mcs") {
		return
	} else {
		command = string(msg.Content[4:])
	}

	switch command {
	case " ping":
		sendText = ":ok_hand: Pong"

	case " start":
		if msg.Author.ID != OwnerID {
			sendText = ":no_good: 駄目です"
			break
		}

		out, err := exec.Command("../script/start.sh").Output()
		if err != nil {
			sendText = ":warning: Command failed"
		} else {
			sendText = string(out)
		}

	case " stop":
		if msg.Author.ID != OwnerID {
			sendText = ":no_good: 駄目です"
			break
		}

		out, err := exec.Command("../script/stop.sh").Output()
		if err != nil {
			sendText = ":warning: Command failed"
		} else {
			sendText = string(out)
		}

	case " status":
		out, err := exec.Command("../script/get_status.sh").Output()
		if err != nil {
			sendText = ":warning: Command failed"
		} else {
			sendText = string(out)
		}

	default:
		sendText = ":book: Usage: `!mcs [ ping | start | stop | status ]`"
	}

	session.ChannelMessageSend(msg.ChannelID, sendText)
}
