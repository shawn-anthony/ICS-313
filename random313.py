#Shawn Anthony
#ICS 312
#Homework 6
#Biagioni
#Fall 2021

#imports for functions
import random
import sys
import string


#initialize variables
arg3 = []
valid = True

#Checking argv
#print (str(sys.argv))

#Handles taking command line arguments from argv
#This is done extremely inefficiently, I could have done this all using arg3 array had I planned that from the start
length = len(sys.argv)
if length == 1:
	arg1 = 0
if length == 2:
	arg1 = sys.argv[1]
if length == 3:
	arg1 = sys.argv[1]
	arg2 = sys.argv[2]
if length > 3:
	arg1 = sys.argv[1]
	arg2 = sys.argv[2]
	count = 1
	while (count < length):
		arg3.append(sys.argv[count])  #Populates arg3 array
		count = count + 1
	#print(arg3)

#Error checks arguments to make sure they are valid
#Refactoring this to only use a single array of args would be infinitely less convoluted
#But refactoring of that level takes too much time
if length == 1:
	valid = True
if length == 2:
	try:
		int(arg1) #Check if int
	except ValueError:
		print("Argument is not an integer")
		valid = False
	if valid == True:
		if int(arg1) < 0:  #If its an int, check if less than zero
			print("Argument is less than zero")
			valid = False
if length == 3:
	if arg1 == '-s' or arg1 == '-c' or arg1 == '-p': #Check if one of our supported chars
		supportedChar = True
	else:
		supportedChar = False
	if supportedChar: #If one of our supported chars, check if arg2 is an int
		try:
			int(arg2)
		except ValueError:
			print("Argument is not supported")
			valid = False
	if not supportedChar: #If arg1 was not one of our supported chars, check if both arg1 and arg2 are ints
		try:
			int(arg1)
			int(arg2)
		except ValueError:
			print("Argument is not supported")
			valid = False
	if valid == True and not supportedChar:
		if int(arg1) > int(arg2):
			print("Argument two is smaller than argument one")
			valid = False

if length == 5 and arg1 == '-c': #Error check the '-c' argument inputs
	try:
		int(arg3[1])
	except ValueError:
		print("Second argument not an integer")
		valid = False
	if valid == True:
		if arg3[2] == '-s': #Handles -s argument combinations if -c is first arg
			try:
				int(arg3[3])
			except ValueError:
				print("Fourth Argument not an accepted input")
				valid = False
		else: #Handle the case where the 4th argument is not '-s' to check if both 4th and 5th are integers instead
			try:
				int(arg3[2])
				int(arg3[3])
			except ValueError:
				print("Last arguments are not both integers or an accepted input")
				valid = False

#If arguments are valid, performs the specified operations
if valid:
	if length == 1: #Case 1
		result = random.randint(0, 100)
		print(result)

	if length == 2: #Case 2
		result = random.randint(0, int(arg1))
		print(result)

	if length == 3: #Handling for Case 3 and 4, with a few base cases for 5 and 8
		if arg1 == '-p': #One Argument permutation Case 6
			print(arg2)

		elif arg1 == '-s': #Case 4
			count = 0
			str = ""
			while count < int(arg2):
				str += random.choice(string.ascii_lowercase)
				count = count + 1
			print(str)

		elif not arg1 == '-c': #Case 3
			result = random.randint(int(arg1), int(arg2))
			print(result)

	if arg1 == '-c': #Case 5
		count = 0
		if length == 3: #Case 1 handling with no additional arguments
			while count < int(arg2):
				result = random.randint(0, 100)
				print(result)
				count = count + 1

		if length == 4: #Case 2 handling with 1 additional argument
			while count < int(arg2):
				result = random.randint(0, int(arg3[2]))
				print(result)
				count = count + 1

		if length == 5 and arg3[2] == '-s': #Case 4 handling with -s as first additional argument
			counter = 0
			count = 0
			str = ""
			while counter < int(arg2): #Basic string generation 
				while count < int(arg3[3]):
					str += random.choice(string.ascii_lowercase)
					count = count + 1
				print(str)
				count = 0
				counter = counter + 1
				str = ""

		else: #Case 3 handling with 2 additional integers as arguments
			count = 0
			while count < int(arg2):
				result = random.randint(int(arg3[2]), int(arg3[3]))
				print(result)
				count = count + 1

	if arg1 == '-p' and length > 3: #Uses random function to generate an int and a list of values to generate permutation
		temp = arg3
		temp.pop(0) #new list for permutation
		while len(temp) > 0: #While we have values in array
			val = random.randint(0, len(temp) - 1) #Generate Value
			print(temp[val]) #Print value at that index
			temp.pop(val) #Remove it so we cannot select it again 
