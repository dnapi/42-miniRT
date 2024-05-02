# MINI_RT_PROJECT_MAKEFILE
include libft/.make

NAME			:=	miniRT

CC				:=	cc
CFLAGS			:=	-g -Wall -Wextra -Werror

# PARSING
PARSING_NAME	:=	error_throw.c parsing.c custom_atof.c pointers_arr_creation.c init_ambient_light.c \
					init_camera.c custom_atoi.c cleaner.c
PARSING_PATH	:=	parsing/
PARSING			:=	$(addprefix $(PARSING_PATH), $(PARSING_NAME))

# SOURCE_FILES
SRCS			:=	main.c $(PARSING)
SRCS_PATH		:=	srcs/

# OBJECT_FILES
OBJS_PATH		:=	objs/
OBJS			:=	$(addprefix $(OBJS_PATH), $(SRCS:.c=.o))

# LIBFT_LIBRARY
LIBFT_PATH		:=	$(LIBFT_PATH)
LIBFT_SOURSES	:=	$(addprefix $(LIBFT_PATH), $(LIBFT_SOURSES))
LIBFT			:=	$(addprefix $(LIBFT_PATH), $(LIBFT))

# HEADERS AND EXTERNAL LIBRARIES
HEADERS			:=	$(LIBFT_PATH)libft.h
INCLUDES		:=	$(addprefix -I , $(HEADERS))
LIBMLX			:=	./lib/MLX42
MLX				:=	./lib/MLX42/build/libmlx42.a
LIBMLX_DIR		:=	$(LIBMLX)/include

# MLX FOR SCHOOL COMPUTERS 
# LIBS			:=	-lft -L $(LIBFT_PATH) -L$(LIBMLX)/build -lmlx42 -L"/opt/homebrew/opt/glfw/lib/" \
# 					-lglfw -framework OpenGL -framework AppKit

# MLX FOR MacOS (M1 and later)
LIBS			:=	-lft -L $(LIBFT_PATH) -L$(LIBMLX)/build -lmlx42 -L"/Users/$(USER)/.brew/opt/glfw/lib" \
					-lglfw -framework OpenGL -framework AppKit

# LOADING PROGRESS BAR INIT
TOTAL_OBJS		:=	$(words $(OBJS))
COMPILED_OBJS	:=	0
MSG_PRINTED 	:=	false

# RULES
all: $(NAME)

$(NAME): $(LIBFT) $(MLX) $(OBJS_PATH) $(OBJS) $(HEADERS)
	@cc $(CFLAGS) $(INCLUDES) $(LIBS) $(OBJS) -o $(NAME)
	@echo "$(GREEN)\n\n$(NAME) created successfully!$(EC)"

$(OBJS_PATH):
	@mkdir -p $(OBJS_PATH)
	@mkdir -p $(OBJS_PATH)$(PARSING_PATH)

$(OBJS_PATH)%.o: $(SRCS_PATH)%.c $(HEADERS)
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@
	@$(call progress,"miniRT")

$(LIBFT): $(LIBFT_SOURSES)
	@$(MAKE) -C $(LIBFT_PATH)

$(MLX):
	@echo "$(CYAN)\nMLX compilation started\n$(EC)"
	@cmake $(LIBMLX) -B $(LIBMLX)/build && make -C $(LIBMLX)/build -j4
	@echo "$(CYAN)\nMLX compilation completed$(EC)"
	@echo "$(GREEN)Library 'libmlx42.a' created successfully$(EC)"

clean:
	@$(MAKE) clean -C $(LIBFT_PATH)
	@rm -rf $(OBJS_PATH)
	@rm -rf $(LIBMLX)/build
	@echo "$(RED)Object files successfully removed!$(EC)"

fclean: clean
	@rm -rf $(NAME)
	@$(MAKE) fclean -C $(LIBFT_PATH)
	@echo "$(RED)\nFull clean up completed successfully!$(EC)"

re: fclean all

.PHONY: all clean fclean re