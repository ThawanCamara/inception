# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tde-souz <tde-souz@student.42.rio>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/04/26 07:08:10 by tde-souz          #+#    #+#              #
#    Updated: 2023/11/04 14:09:18 by tde-souz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ******************************************************************************
# *									SETTINGS								   *
# ******************************************************************************
NAME		:=	Inception

CURRENT_OS	:=	$(shell uname)
#INCLUDES	=	-I libft/ -I includes 
#LIBFT_DIR	:=	libft/
#LIBFT		:=	libft
#MLX			:=	libmlx

# ******************************************************************************
# *								   TEXT COLORS								   *
# ******************************************************************************
GREEN		:=	\e[38;5;118m
YELLOW		:=	\e[38;5;11m
GOLD		:=	\e[38;5;220m
RESET		:=	\e[0m
BOLD		:=	\e[1m

TIME		:= \e[38;5;8m($(shell date +%H:%M:%S))${RESET}
START		:=	${GREEN}START:\t${RESET}
INFO		:=	${YELLOW}INFO:\t${RESET}

# ******************************************************************************
# *								   SOURCE FILES								   *
# ******************************************************************************
SRC		:=	./srcs

# ******************************************************************************
# *                                   RULES                                    *
# ******************************************************************************
all:		${NAME}

${NAME}: up
	@printf '${TIME} ${START}${NAME} on ${CURRENT_OS}\n'
	
#	@docker build -t nginx42:inception srcs/requirements/nginx/
#	@docker build -t mariadb42:inception srcs/requirements/mariadb/

up:
	@cd ${SRC} && docker compose up -d
	@docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

down: stop
		@cd $(SRC) && docker compose down

stop:
		@cd $(SRC) && docker compose stop

clean: down
	@printf "${TIME} ${INFO}Remove specific images\n"
	@docker images "srcs*" --format {{.ID}} | xargs -r docker rmi -f

fclean:		clean
	@printf "${TIME} ${INFO}Remove specific volumes\n"

re:			fclean all

.PHONY: all clean fclean re leak
