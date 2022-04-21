extends Node

var yellowSpool = false
var redSpool = false
var blueSpool = false
var collectables = 0

func getYellow():
	return yellowSpool
func getRed():
	return redSpool
func getBlue():
	return blueSpool
func getCollectables():
	return collectables

func setYellow(yellow):
	yellowSpool = yellow
func setRed(red):
	redSpool = red
func setBlue(blue):
	blueSpool = blue
func setCollectables(num):
	collectables = num
