def GetGuess(): #this is the the main function for getting the guesses from the player. As you see there are no variables inside the () so this function does not need any initial variables
    
    dashes = "-" * len(secret_word) #this line difinies a variable called dashes which has as many dashes as the length of the secret word
    guesses_left = 10 #you only give the player ten wrong guesses. Once you get more advaced you can ask the player what level they want. This variable is an intiger



    
    #This will loop as long as BOTH conditions are true:
    #   1.The number of guesses left is greater than -1
    #   2.The dash string does not equal the secret word
    while guesses_left>-1 and not dashes==secret_word: 
	
    # print the amount of dashes and guesses left
        print(dashes) 
        print(str(guesses_left)) 
     # ask for user input
        guess= input("Guess: ") 
	    
	    
    # if the guess is in the secret word then we update dashes to replace the 
    # the corresponding with the correct index that the guess belongs to in
    # the secret word	
        if guess in secret_word: 
            print ("that letter is in the secret word!") 
            dashes=Update_dashes(secret_word, dashes, guess)
    # if the guess is wrong then we display a message and subtract 
    # the amount of guesses the user has by 1    
        else: 
            print ("that letter is not in the secret word!")
            guesses_left -=1 
    


	    
    if guesses_left<0:
            print ("You lose. The word was " + str(secret_word))
         # if the dash equals the secret word in the end then the user wins
    else:
            print ("Congrats! You win. The word was "+ str(secret_word))
            
