# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tde-souz <tde-souz@student.42.rio>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/04/26 07:08:10 by tde-souz          #+#    #+#              #
#    Updated: 2023/11/05 15:14:17 by tde-souz         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ******************************************************************************
# *									SETTINGS								   *
# ******************************************************************************
NAME		:=	inception

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
DCF		:=	./srcs/docker-compose.yml

# ******************************************************************************
# *                                   RULES                                    *
# ******************************************************************************
all:		${NAME}

${NAME}: up
	@printf '${TIME} ${START}${NAME} on ${CURRENT_OS}\n'

clean: down
	@printf "${TIME} ${INFO}Removing images\n"
	@docker images "${NAME}*" --format {{.ID}} | xargs -r docker rmi -f
#	@docker images "srcs*" --format {{.ID}} | xargs -r docker rmi -f

fclean:		clean
	@printf "${TIME} ${INFO}Remove specific volumes\n"
	@sudo rm -rf srcs/.data/
	@docker volume ls --filter "Name=${NAME}*" --format "{{.Name}}" | xargs -r docker volume rm

re:	fclean all

up:
	@sudo mkdir -p srcs/.data/mariadb
	@sudo mkdir -p srcs/.data/wordpress
	@docker-compose -p ${NAME} -f ${DCF} up -d
	@docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

down: stop
	@docker-compose -p ${NAME} -f ${DCF} down

stop:
	@docker-compose -p ${NAME} -f ${DCF} stop

log:
	@docker-compose -p ${NAME} -f ${DCF} logs

status:
	@docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"

debug:
	@printf "${GOLD}██████████████████████ Containers ███████████████████████${RESET}\n"
	@docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
	@printf "${GOLD}██████████████████████   Images   ███████████████████████${RESET}\n"
	@docker images
	@printf "${GOLD}██████████████████████   Volumes  ███████████████████████${RESET}\n"
	@docker volume ls

.PHONY: all clean fclean re leak
