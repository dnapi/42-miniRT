/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.h                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: dnikifor <dnikifor@student.hive.fi>        +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/11/09 16:39:46 by dnikifor          #+#    #+#             */
/*   Updated: 2024/04/27 11:59:55 by dnikifor         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GET_NEXT_LINE_H
# define GET_NEXT_LINE_H

# ifndef BUFFER_SIZE
#  define BUFFER_SIZE 1000
# endif

# include <unistd.h>
# include <stdlib.h>

char	*get_next_line(int fd, int *status, char **string);
char	*ft_strchr(const char *s, int c);
char	*ft_strncpy(char *dest, char *src, size_t n);
char	*ft_free(char *s);
char	*add_to_string(char *s, char *buffer, size_t buf_len);
char	*check_string(char *s, int *status);

#endif
