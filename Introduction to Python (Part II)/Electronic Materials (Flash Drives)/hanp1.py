'''============================================================
This is a python script to play the hangman game
The computer acts as player 1 and selects a secret word. The user is player 
on each turn
    player 2 guesses a letter
    if correct it is added to the word
    if incorrect, loss one score
============================================================='''


import random 

wordlist=["python","happy", "learning"] 

secret_word=random.choice(wordlist) 