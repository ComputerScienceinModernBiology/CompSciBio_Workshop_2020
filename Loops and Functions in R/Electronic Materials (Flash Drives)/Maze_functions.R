#### Computer Science Workshop 
#### Miami University - Oklahoma University 
#### Course: Loops and Functions in R
#### Instructor: Alfredo Ascanio
#### Assistant instructors: Tereza Jezkova, Meelyn Pandit
#### Date: 08/10/2020-08/14/2020 

#### Load required packages ####
require(tidyverse)

#### Function for plotting and storing a bifurcating maze ####
make_maze <- function(maze_levels = 3) {
    #create empty DF
    maze_df <- data.frame(y = 0, x = 0, open =  1, xinit = 0, yinit = 0)
    
    for(i in 1:maze_levels) {
        # Maze steps for maze DF #
        x <- maze_df$x[maze_df$open == 1 & maze_df$y == i - 1]
        maze_step <- data.frame(y = c(i, i), x = c(x - 0.5, x + 0.5))
        left <- rbinom(1, 1, 0.5)
        maze_step$open <- c(left, ifelse(left == 1, yes = 0, no = 1))
        maze_step$xinit <- x
        maze_step$yinit <- i - 1
        
        maze_df <- rbind(maze_df, maze_step)
        
    }
    
    # Plot Maze #
    maze_plot <- ggplot(maze_df, aes(x = x, y = y, col = factor(open, labels = c("closed", "open")))) +
        geom_segment(aes(x = xinit, y = yinit, xend = x, yend = y), col = "black", size = 1) +
        geom_point(size = 3) +
        scale_color_manual("", values = c("red", "blue")) +
        theme_bw() +
        theme(legend.position = "bottom")
    
    print(maze_plot)
    
    # Return DF as output
    return(maze_df)
}

#### Plot maze function, if DF was previously stored ####
plot_maze <- function(maze_df) {
    maze_plot <- ggplot(maze_df, aes(x = x, y = y, col = factor(open, labels = c("closed", "open")))) +
        geom_segment(aes(x = xinit, y = yinit, xend = x, yend = y), col = "black", size = 1) +
        geom_point(size = 3) +
        scale_color_manual("", values = c("red", "blue")) +
        theme_bw() +
        theme(legend.position = "bottom")
    
    print(maze_plot)
}

#### Locate yourself in a specific step of a previously created MazeDF ####
#Outputs a new plot and a smaller data frame
where_are_you <- function(maze_df, size = 4) {
    where_maze <- sample(which(maze_df$open == 1)[-ceiling(nrow(maze_df)/2)], 1)
    maze_df$open[where_maze] <- 2
    where_maze <- maze_df[c(where_maze, which(maze_df$y == maze_df$y[where_maze] + 1)), ]
    
    maze_plot <- ggplot(maze_df, aes(x = x, y = y, col = factor(open, labels = c("closed", "open", "You are here"), levels = c(0, 1, 2)))) +
        geom_segment(aes(x = xinit, y = yinit, xend = x, yend = y), col = "black", size = 1) +
        geom_point(size = 3) +
        scale_color_manual("", values = c("red", "blue", "green")) +
        geom_point(data = where_maze[1, ], mapping = aes(x = x, y = y), col = "green", size = size, inherit.aes = F) +
        theme_bw() +
        theme(legend.position = "bottom")
    
    print(maze_plot)
    return(where_maze)
}



#Maze <- make_maze(3)
#plot_maze(Maze)

#where <- where_are_you(Maze, 5)
#where_at <- where

#for(i in unique(Maze$y)[-1]) {
#    where_at <- Maze[Maze$y == i, ]
#    if(where_at$x[where_at$open == 1] > 	where_at$x[where_at$open == 0]) {
#    print("Right") } else {
#        print("Left")
#    }
#}
