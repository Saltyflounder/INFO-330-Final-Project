FIFA World Cup Management and ER Database Integration 


Brief description of the organization
The FIFA World Cup is the most prestigious and popular international football tournament in the world. It is organized by the Fédération Internationale de Football Association (FIFA), the global governing body of football. The FIFA World Cup takes place every four years, with 32 teams competing for the title in the final tournament. The host nation (s) automatically qualify for the final tournament, while the other teams have to go through a qualification phase that lasts for about three years. The FIFA World Cup has been held since 1930, except for 1942 and 1946 due to the Second World War. 

The FIFA World Cup is not only a sporting event, but also a cultural and social phenomenon that brings together millions of fans around the world. The World Cup FIFA also has a significant impact on the development and promotion of football, as well as on the economy, environment and human rights of the host countries and regions.

FIFA wants to streamline and improve its management of the FIFA World Cup, including team, match, sponsor, round, referee, stadium, and city information, to enhance the overall organization of the tournament and its related activities.

Implementing an ER database based on the provided information can help FIFA streamline its operations, improve tournament planning, enhance sponsor relationships, ensure fair play, and better manage its responsibilities related to the environment and human rights. For instance, by analyzing historical match data, FIFA could optimize scheduling to minimize team travel, ensuring players have adequate rest between matches and improving the quality of play. Additionally, insights from sponsor and team relationships could be used to strategically plan marketing campaigns and events in cities with high fan engagement, maximizing exposure and return on investment for sponsors. This ultimately contributes to the success and positive impact of the FIFA World Cup, making it a well-organized, culturally significant, and economically beneficial event for fans, sponsors, and host regions.

After the research from FIFA World Cup website, we discovered the following business rules:
A team can attend many matches, and a match has more than one team. A composition may be away-team and home-team.
A team can have many sponsors, and sponsors can sponsor many teams.
A match can be assigned in one round, and one round can have many matches.
A referee can referee many matches, and one match can only have one referee.
A stadium can hold many matches, and a match can be held in only one stadium.
A city can host many stadiums, and a stadium can be hosted in only one city.
A city can host matches in many different years, and matches in a year can be hosted in many cities.

Initial list of the main entities

SPONSOR
The companies or organizations that provide financial support for the team
TEAM
The participating national teams in the World Cup
REFEREE
The officials responsible for enforcing the rules of the match
MATCH
The individual games played during the World Cup
ROUND
The different stages of the World Cup
STADIUM
The venues where the matches are played
CITY
A specific city that host one or more matches of the tournament
FIXTURE
A specific year in which the tournament is held


In the above preliminary conceptual model,
The first business rule is shown with a many-to-many relationship (M:N) between team and match.
The second business rule is shown with a many-to-many (M:N) relationship between sponsor and team.
The third business rule is shown with a one-to-many (1:M) relationship between round and match.
The fourth business rule is shown with a one-to-many (1:M) relationship between referee and match.
The fifth business rule is shown with a one-to-many (1:M) relationship between stadium and match.
The sixth business rule is shown with a one-to-many (1:M) relationship between city and stadium.
The seventh business rule is shown with a many-to-many (M:N) relationship between city and fixture (year).









High-level Conceptual Model


























Work Cited

Gibin, W. O. (2020, November 18). World Championschip Cup FIFA. https://www.kaggle.com/datasets/willianoliveiragibin/world-championschip-cup-fifa


