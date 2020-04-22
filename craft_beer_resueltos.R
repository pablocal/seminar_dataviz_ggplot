# Metadata ----------------------------------------------------------------
# Title: Ejercicios r & ggplot2
# Purpose: Resueltos
# Author(s): @pablocal
# Date: 2020-04-22
#
# Comments ----------------------------------------------------------------
# 
# Antes de comenzar recuerda:
#   1. Para EJECUTAR una línea del script usa Ctrl+Enter o el botón Run.
#   2. Todas las líneas antecedidas por "#" son comentarios y no se ejecutarán.
#   3. Si en algún momento quieres comenzar desde cero usa Ctrl+Mayús+F10.
#
# Options and packages ----------------------------------------------------

# Cargar paquetes y datos -------------------------------------------------
# En R los paquetes se instalan con la función install.packages() y se 
# cargan con la función library(). Hoy vamos a utilizar dos paquetes:
#   ggplot2: visualización de datos
#   ggthemes: extensión de ggplot que contiene temas precargados
# Los paquetes ya están instalados y sólo hay que cargarlos.
library(ggplot2)
library(ggthemes)

# Cargar los datos asignándolos al objetto beers. Al ser los datos en formato
# CSV se cargan con la función read.csv():
beers <- read.csv("beers.csv")

# Try It 1: Explorar los datos --------------------------------------------

# Para explorar los datos puedes utilizar las siguientes funciones:
#   str() para conocer la estructura de los datos
#   head() para visualizar las primeras filas y variables de los datos
#   summary() para obtener estadísticos descriptivos de las variables
# Utiliza las tres funciones para explorar los datos:

str(beers)
head(beers)
summary(beers)


# Try It 2: Plot básico ---------------------------------------------------

# a)
# A partir de los datos de beers vamos a estudiar la relación entre el 
# volumen de alcohol (alc_vol) y el grado de amargura (bitterness) según
# la familia de la cerveza (family). Para ello vamos a realizar un plot de 
# dispersión (puntos). Todos los plots precisan de tres elementos básicos: 
# datos, aesthetics y geometrías. Antes de comenzar con el código completa 
# la siguiente tabla:

# Datos: beers
# Aesthetics: x = alc_vol, y = bitter, color = family
# Geometría: geom_point

# Ahora sustituye los ____ por los valores adecuados y ejecuta el código:
plot_beer <- ggplot(data = beers, mapping = aes(x = alc_vol, y = bitter, color = family)) +
  geom_point()

# Ejecuta la siguiente línea para ver el gráfico:
plot_beer

# b)
# El principal problema de este plot es la densidad de los puntos en la parte 
# inferior izquierda. Para solucionarlo vamos a utilizar dos argumentos 
# dentro de la función geom_point(): alpha y position.
# 
# El argumento alpha sirve para aplicar un nivel de tranparencia, 
# en este caso a los puntos. La escala va de 0 (completamente transparente) a 
# 1 (completamente opaco). Para este plot utiliza un alpha = .4. 
# 
# El argumento position permite modificar la posición de los puntos
# para que haya menos sueprposición. Para ello, utiliza el argumento
# position = "jitter" (incluye las comillas).

plot_beer <- ggplot(data = beers, mapping = aes(x = alc_vol, y = bitter, col = family)) +
  geom_point(alpha = .4, position = "jitter") 

plot_beer

# c)
# Por último, vamos a incluir una línea de ajuste, esto es, otra geometría que resuma 
# la relación lineal entre alc_vol y bitter. Para ello usaremos el geom_smooth con 
# tres argumentos: method = "lm", color = "darkred" y se = FALSE. 
# 
# El argumento *method* sirve para determinar el método con el que se ajusta la línea. 
# Por ejemplo, "lm" corresponde a linear model, otra opción es utilizar un ajuste 
# no lineal como "loess", 
# 
# El argumento *color* se refiere al color de la línea. En caso de no especificarlo
# el color se heredaría de la función ggplot() y se produciría una línea para cada
# subgrupo de la variable family. Par auna lista de colores completa: 
# http://bc.bojanorama.pl/wp-content/uploads/2013/04/rcolorsheet.pdf
# 
# El argumento *se* determina la inclusión de un sombreado alrededor de la línea
# que representa el error de la estimación. Este argumento solo toma dos valores:
# TRUE o FALSE.

plot_beer <- plot_beer + geom_smooth(method = "lm", color = "darkred", se = FALSE)

plot_beer


# Try It 3: Aspecto ---------------------------------------------------

# a) 
# Para incluir las etiquetas se utiliza la función labs(). Los 
# argumentos de esta función corresponden a las diferentes etiquetas.
# En este caso añade etiquetas: title, subtitle, caption, x, y, color.
# En el caso de color, para eliminar el título de la leyenda, está prefijado
# en NULL.

plot_beer <- plot_beer + 
  labs(title = "Grab a beer",
       subtitle = "Pale ales are more bitter than actual bitters",
       caption = "@pablocalv · CraftBeer dataset",
       x = "Alcohol (vol. %)",
       y = "Bitterness",
       color = NULL)

plot_beer

# b)
# Quedan por modificar todos los demás aspectos visuales que no se
# corresponden con los propios datos. Por ejemplo, el uso de las 
# líneas de grid, color del fondo del plot, tamaño y color de los 
# títulos y las etiquetas de los ejes...
# 
# Una opción más fácil consiste en utilizar unos temas prediseñados 
# que están incluidos en el paquete ggplot2 o en su extensión ggthemes. 
# Todas las funciones referidas a los temas comienzan como "theme_". Prueba
# con theme_light(), theme_economist() y theme_fivethirtyeight(). Estas funciones
# no precisan argumentos.
# 
# Cuando tengas un tema preferido, guárdalo en el objeto plot_beer.

plot_beer + theme_light()
plot_beer + theme_economist()
plot_beer + theme_fivethirtyeight()

plot_beer <- plot_beer + theme_light()

# c)
# Por último, graba el gráfico utilizando la función ggsave(). Puedes
# guardarlo en el formato que prefieras (png, jpg, eps, pdf...) con solo
# cambiar la extensión del archivo de formato.

ggsave(filename = "plot_beer.pdf", plot = plot_beer)







