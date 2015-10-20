library("igraph")
library("dplyr")
library("readr")

# Read in the main data, and split the bipartite network into two different graphs
affiliations <- read_csv("Data/networksocieties.csv")

g <- graph_from_data_frame(affiliations, directed = FALSE)
V(g)$type <- bipartite_mapping(g)$type
bi_g <- bipartite_projection(g)
members   <- bi_g$proj1
societies <- bi_g$proj2

# Munge the data for societies
societies_node_attr <- affiliations %>% 
  select(Organization, shape, color, location) %>% 
  distinct()

societies_edge_attr <- get.data.frame(societies)

write_csv(societies_node_attr, "data/societies-node-attr.csv")
write_csv(societies_edge_attr, "data/societies-edge-attr.csv")

# Munge the data for members: not going to actually do this because the members
# graph is huge, and we aren't going to plot it anyway.
# members_node_attr <- affiliations %>% 
#   select(Name, Status, color = member_color, shape = member_shape)
# 
# members_edge_attr <- get.data.frame(members)
# 
# write_csv(members_node_attr, "data/members-node-attr.csv")
# write_csv(members_edge_attr, "data/members-edge-attr.csv")
