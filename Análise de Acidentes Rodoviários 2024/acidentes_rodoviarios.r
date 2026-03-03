# --- CONFIGURAÇÃO INICIAL ---
setwd(".")

library(dplyr)
library(ggplot2)

# --- CARGA DE DADOS ---
dados <- read.csv("datatran2024.csv", sep = ";", fill = TRUE, check.names = FALSE, fileEncoding = "latin1")

# Verificar se os dados carregaram corretamente
print("Estrutura dos dados:")
str(dados)

# --- ANÁLISE PARA O TRABALHO ---

# 1. Estado com maior número de acidentes
acidentes_por_uf <- dados %>%
  group_by(uf) %>%
  summarise(total = n()) %>%
  arrange(desc(total))

print("Top 5 Estados com mais acidentes:")
print(head(acidentes_por_uf, 5))

# 2. Probabilidade de acidentes em condições climáticas claras
total_geral <- nrow(dados)
claro_count <- nrow(filter(dados, condicao_metereologica == "Céu Claro"))
probabilidade_ceu_claro <- (claro_count / total_geral) * 100

cat("A probabilidade de acidentes com Céu Claro é:", probabilidade_ceu_claro, "%\n")

# 3. Visualização: Acidentes por fase do dia
grafico <- ggplot(dados, aes(x = fase_dia)) +
  geom_bar(fill = "darkred") +
  labs(
    title = "Acidentes por Fase do Dia",
    x = "Fase do Dia",
    y = "Quantidade de Ocorrências"
  ) +
  theme_minimal()
# Salva o arquivo na pasta de origem
ggsave("grafico_acidentes.png", plot = grafico, width = 8, height = 6, dpi = 300)

# No VS Code, o gráfico aparecerá na aba 'R Plot' ou em uma janela separada
print(grafico)

