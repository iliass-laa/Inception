VOLUMEPATH = /home/${USER}/data
WORDPRESS_V = $(VOLUMEPATH)/wordpress
MARIADB_V = $(VOLUMEPATH)/mariadb

# NAME = alo

# all : $(NAME)


# $(NAME):
# 	@echo $(VOLUMEPATH)
# 	@echo $(MARIADB_V)
# 	@echo $(WORDPRESS_V)


# clean :
# 	rm -rf $(NAME)


all : build setup


build :
	@echo "Building ..."
	@mkdir -p $(WORDPRESS_V)
	@mkdir -p $(MARIADB_V)

setup :
	@echo "Setuping ..."




