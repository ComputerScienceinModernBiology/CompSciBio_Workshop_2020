# This function updates the string of dashes by replacing the dashes with 
# characters that are present in the hidden word if the user manages 
# to guess it correctly

def Update_dashes(secret, cur_dash, rec_guess): 
    result="" 
    for i in range(len(secret)):
        if secret[i]==rec_guess: 
            result=result+rec_guess #adds guess to the string if the 
            # guess is correct
        else: 
        # add the dash at index i to the result if it doesnt match the guess
            result=result+cur_dash[i]
   
    return result 
