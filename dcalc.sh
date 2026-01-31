#!/usr/bin/bash

calc() {
	notify-send $(dmenu -p "calc" <&- | bc -l 2>/dev/null)
}

calc
