VOLUMEPATH = ${HOME}/data
WORDPRESS_V = $(VOLUMEPATH)/wordpress
MARIADB_V = $(VOLUMEPATH)/mariadb



all : build setup


build :
	@echo "Building ..."
	@mkdir -p $(WORDPRESS_V) && \
	mkdir -p $(MARIADB_V) && \
	cd ${PWD}/srcs ; docker compose build


setup :
	@echo "Setuping ..."
	@cd ${PWD}/srcs; docker compose up -d

cleanBonus :
	@echo cleaning Bonus ...
	@cd ${PWD}/srcs;docker compose stop adminer ;docker compose rm -f adminer 

clean :
	@echo cleaning ...
	@cd ${PWD}/srcs;docker compose down -v


fclean : clean
	@echo full cleaning ...
	@sudo rm -rf $(WORDPRESS_V)
	@sudo rm -rf $(MARIADB_V)



re : fclean all

logs:
	@cd ${PWD}/srcs && docker compose logs -f

status:
	@cd ${PWD}/srcs && docker compose ps


.PHONY : all clean fclean re build setup status logs



