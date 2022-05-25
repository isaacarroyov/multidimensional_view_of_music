library(dplyr)
library(ggplot2)

# LOAD DATA
df <- read.csv("./data/harrys_house_audio_features.csv")



# DATA PROCESSING
df <- df %>%
  mutate(loudness = (loudness - min(loudness))/(max(loudness) - min(loudness)),
         song_position = 1:13) %>%
  select(song_name, song_position, acousticness, danceability,
         energy, loudness, valence, speechiness) %>%
  tidyr::pivot_longer(cols = 3:8, names_to = "audio_features", values_to = "values") %>% as.data.frame() 


# Data Visualization
theme_set(theme_light(base_family = "Verdana"))

df %>%
  ggplot(aes(x=song_position, y = values,
             size = values, color = audio_features, 
             label = round(values,3) )) +
  geom_point() + 
  geom_text(size=3, color = 'black') + 
  scale_size_area(max_size = 15) + 
  scale_color_manual(values = c("#C8B486", "#87342F", "#DFC34A", "#315C03", "#8A6542", "#255071")) + 
  coord_cartesian(clip = "off") +
  facet_wrap(~audio_features) +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    strip.text = element_blank(),
    legend.title = element_blank(),
  )


ggsave("./images/multidimensional_view_of_harrys_house.svg", units = "px",
       width = 1080, height = 1080, scale = 1.5)
