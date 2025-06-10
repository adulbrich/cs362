library(data.table)
library(stringr)
library(ggplot2)

filename_groups <- "data/CS362_S2025_Teams.csv"

team_sizes <- fread(filename_groups, header = TRUE)
team_sizes <- team_sizes[, .(n = .N), by = group_name]
setnames(team_sizes, "group_name", "Team")

filename <- "data/CS_362_001_S2025 Team Peer Evaluations_June 10, 2025_09.57.csv"

dt <- fread(filename, header = TRUE)

labels <- data.table(question_id = colnames(dt), question_label = as.list(dt[1, ]))
dt <- dt[-1, ]
dt <- dt[-1, ]

# clean up columns
dt[, StartDate := NULL]
dt[, EndDate := NULL]
dt[, Status := NULL]
dt[, IPAddress := NULL]
dt[, Progress := NULL]
dt[, `Duration (in seconds)` := NULL]
dt[, Finished := NULL]
dt[, RecordedDate := NULL]
dt[, ResponseId := NULL]
dt[, ExternalReference := NULL]
dt[, LocationLatitude := NULL]
dt[, LocationLongitude := NULL]
dt[, DistributionChannel := NULL]
dt[, UserLanguage := NULL]

# add team size
dt <- merge(dt, team_sizes, by = "Team")

### Question 2
# X goes from 1 to 4, 1 is self, 2-4 are team members

# Does the member do an appropriate quantity of work?
# labels[,Q2_X_1]

# How about the quality of the member’s work?
# labels[,Q2_X_2]

# Rate the member’s attitude as a team player (eager to do assigned work, communicated with others, kept appointments, etc.).
# labels[,Q2_X_3]

# Rate the overall value of the member’s technical contribution.
# labels[,Q2_X_4]

# Would you want to work with this person on a project again?
# labels[,Q2_X_5]

### Question 3
# Take 100 points, and divide them among the N team members, including yourself. Give points based on your opinion of what proportion of the credit each member deserves. You may consider quality and quantity of contributions, team-player attitude, and/or any aspects that you feel are relevant. You must give yourself at least 100/N points, whether you honestly feel you deserve them or not. (This is to avoid an unrealistic “self-incrimination” requirement.)
# X goes from 1 to 4, 1 is self, 2-4 are team members
# labels[,Q3_X]

output <- dt[, .(Name = str_c(RecipientLastName, ", " , RecipientFirstName),Email=RecipientEmail, Team, n, `Team Member 1`, `Team Member 2`, `Team Member 3`)]
# need to make sure results are unique

for (i in 1:nrow(output)) {
   # i <- 1
   team <- output[i, Team]
   email <- output[i, Email]
   results <- dt[Team == team & RecipientEmail != email,]
   q21 <- c()
   q22 <- c()
   q23 <- c()
   q24 <- c()
   q25 <- c()
   q3  <- c()
   if (nrow(results) == 0) {
       # if no results, just add NA
       output[i, Q21 := list(NA)]
       output[i, Q22 := list(NA)]
       output[i, Q23 := list(NA)]
       output[i, Q24 := list(NA)]
       output[i, Q25 := list(NA)]
       output[i, Q3  := list(NA)]
       next
   }
   for (j in 1:nrow(results)) {
       # j <- 1
       # find which team member X this is and add one (because first entry is self)
       x <- as.numeric(str_extract(colnames(results)[which(results[j,] == email)], "\\d")) + 1
       if (length(x) == 0) {
           q21 <- c(q21, NA)
           q22 <- c(q22, NA)
           q23 <- c(q23, NA)
           q24 <- c(q24, NA)
           q25 <- c(q25, NA)
           q3  <- c(q3,  NA)
           next
       }
       q21 <- c(q21, results[j, get(str_c("Q2_",x,"_1"))])
       q22 <- c(q22, results[j, get(str_c("Q2_",x,"_2"))])
       q23 <- c(q23, results[j, get(str_c("Q2_",x,"_3"))])
       q24 <- c(q24, results[j, get(str_c("Q2_",x,"_4"))])
       q25 <- c(q25, results[j, get(str_c("Q2_",x,"_5"))])
       q3  <- c(q3,  results[j, get(str_c("Q3_",x))])
   }
   output[i, Q21 := list(q21)]
   output[i, Q22 := list(q22)]
   output[i, Q23 := list(q23)]
   output[i, Q24 := list(q24)]
   output[i, Q25 := list(q25)]
   output[i, Q3  := list(q3 )]
}

output[!is.na(Q21), Q21_mean := sapply(Q21, function(x) mean(as.numeric(unlist(x)), na.rm = TRUE)), by = Email]
output[!is.na(Q22), Q22_mean := sapply(Q22, function(x) mean(as.numeric(unlist(x)), na.rm = TRUE)), by = Email]
output[!is.na(Q23), Q23_mean := sapply(Q23, function(x) mean(as.numeric(unlist(x)), na.rm = TRUE)), by = Email]
output[!is.na(Q24), Q24_mean := sapply(Q24, function(x) mean(as.numeric(unlist(x)), na.rm = TRUE)), by = Email]
output[!is.na(Q25), Q25_mean := sapply(Q25, function(x) mean(as.numeric(unlist(x)), na.rm = TRUE)), by = Email]
output[!is.na(Q3) , Q3_mean  := sapply(Q3 , function(x) mean(as.numeric(unlist(x)), na.rm = TRUE)), by = Email]

output[!is.na(Q21), Q21_normalized := (Q21_mean * 10) + 50]
output[!is.na(Q22), Q22_normalized := (Q22_mean * 10) + 50]
output[!is.na(Q23), Q23_normalized := (Q23_mean * 10) + 50]
output[!is.na(Q24), Q24_normalized := (Q24_mean * 10) + 50]
output[!is.na(Q25), Q25_normalized := (Q25_mean * 10) + 50]
output[!is.na(Q3) , Q3_normalized   := Q3_mean * n]

output[, Q3_shifted := Q3_normalized / 5]
output[Q3_shifted < 10, Q3_shifted := 10]
output[Q3_shifted > 40, Q3_shifted := 40]
output[, Q3_shifted := (0.65 + (0.0225 * Q3_shifted) - (0.00025 * Q3_shifted ^ 2)) * 100]

output[, PeerEvaluationScore := (Q21_normalized + Q22_normalized + Q23_normalized + Q24_normalized + Q3_shifted) / 5]

fwrite(output, "data/CS_362_001_S2025_Peer_Review_Grades.csv", row.names = FALSE)

ggplot() +
  # Original distribution
  geom_histogram(data = output, aes(x = Q3_normalized, fill = "Original"), 
                 bins = 20, alpha = 0.5) +
  # Shifted distribution
  geom_histogram(data = output, aes(x = Q3_shifted, fill = "Shifted"), 
                 bins = 20, alpha = 0.5) +
  scale_fill_manual(values = c("Original" = "#4285F4", "Shifted" = "#DB4437")) +
  labs(
    title = "Distribution of Peer Evaluation Scores",
    subtitle = "Original vs Shifted (min = 50) distribution",
    x = "Peer Evaluation Score",
    y = "Count",
    fill = "Distribution",
    caption = "Data from Qualtrics Team Peer Review Survey"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold"),
    legend.position = "top"
  )


# merge with gradebook

filename_gradebook <- "data/2025-06-10T0945_Grades-SOFTWARE_ENGINEERING_II_(CS_362_001_S2025).csv"

gradebook <- fread(filename_gradebook, header = TRUE)

output[, `SIS Login ID` := Email]

gradebook <- merge(gradebook, output[, .(`SIS Login ID`, PeerEvaluationScore)], by = "SIS Login ID", all.x = TRUE)

gradebook[, `Project Peer-Evaluation (10042163)` := PeerEvaluationScore]
gradebook[, PeerEvaluationScore := NULL]

gradebook[is.na(`Project Peer-Evaluation (10042163)`), `Project Peer-Evaluation (10042163)` := 60]

fwrite(gradebook, "data/CS_362_001_S2025_Peer_Review_Grades_Gradebook.csv", row.names = FALSE)
