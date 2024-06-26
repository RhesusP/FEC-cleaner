# ------------------------------------------------------------------------------
# Makefile for FEC_cleaner project
# ------------------------------------------------------------------------------
# Author: Camille BERNOT (camil.bernot.cb@gmail.com)
# Description: Makefile for building the FEC_cleaner project.
# Version: 0.1
# Date: 2024-06-26
# ------------------------------------------------------------------------------

.PHONY: all clean fclean re
NAME	:=	FEC_cleaner

# ------------------------------------------------------------------------------
# ALL FILES
# ------------------------------------------------------------------------------

# Files
LST_SRC	:=	cleaner.cpp

# Directories
DIR_SRC	:=	src/
DIR_OBJ	:=	.obj/

# Shortcuts
SRCS	:=	$(addprefix $(DIR_SRC), $(LST_SRC))
OBJS	:=	$(subst $(DIR_SRC), $(DIR_OBJ), $(SRCS:.cpp=.o))

# ------------------------------------------------------------------------------
# COMMAND VARIABLES
# ------------------------------------------------------------------------------

# Commands
CC				:=	c++
CFLAGS			:=	-Wall -Wextra -Werror -std=c++17
RM				:=	rm -rf

# Colors
BLACK=\033[30m
RED=\033[31m
GREEN=\033[32m
YELLOW=\033[33m
BLUE=\033[34m
PURPLE=\033[35m
CYAN=\033[36m
WHITE=\033[37m

# Text
ERASE=\033[2K\r
RESET=\033[0m
BOLD=\033[1m
FAINT=\033[2m
ITALIC=\033[3m
UNDERLINE=\033[4m

# ------------------------------------------------------------------------------
# RULES
# ------------------------------------------------------------------------------

all: $(NAME)

$(NAME): $(OBJS) $(INCS)
	@$(CC) $(CFLAGS) $(CI) $(OBJS) -o $@
	@echo "$(ERASE)\n$(PURPLE)$(BOLD)🎉🎉 executable $(NAME) created 🎉🎉$(RESET)"

$(DIR_OBJ)%.o: $(DIR_SRC)%.cpp $(INCS) | $(DIR_OBJ)
	@$(CC) $(CFLAGS) $(CI) -c $< -o $@
	@echo "$(ERASE)$(BOLD)$(NAME)$(RESET)$(GREEN) compiling... $(RESET)$<"

$(DIR_OBJ):
	@mkdir -p $(DIR_OBJ)
	@echo "$(ERASE)$(BOLD)$(NAME)$(RESET)$(GREEN) objects directory created.$(RESET)"

# Cleaning
clean:
	@$(RM) $(OBJS)
	@if [ -d "$(DIR_OBJ)" ]; then \
		$(RM) $(DIR_OBJ); echo "$(ERASE)$(BOLD)$(NAME)$(RESET)$(RED) objects deleted.$(RESET)"; \
	fi

fclean: clean
	@if [ -f "$(NAME)" ]; then \
		$(RM) $(NAME); echo "$(ERASE)$(RED)$(BOLD)🗑️  $(NAME) deleted.$(RESET)"; \
	fi

re: fclean all