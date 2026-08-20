
/* Mock Statcast-style batted-ball leaderboard rows, standing in for the
   PROC IMPORT DATAFILE=REFFILE CSV read in the original script (REFFILE
   is a SAS-Studio "Import Data" wizard fileref with no FILENAME statement
   in the source, so it cannot run standalone). Same column names/shapes
   as the real Baseball Savant export the script was written against. */
data BASEBALL;
  infile datalines dsd dlm=',';
  length last_name $20 first_name $20;
  input last_name $ first_name $ player_id year
        exit_velocity_avg launch_angle_avg barrel_batted_rate
        solidcontact_percent flareburner_percent poorlyunder_percent
        poorlytopped_percent poorlyweak_percent hard_hit_percent
        z_swing_percent oz_swing_percent oz_contact_percent out_zone_percent
        iz_contact_percent in_zone_percent edge_percent whiff_percent
        pull_percent straightaway_percent opposite_percent
        groundballs_percent flyballs_percent linedrives_percent popups_percent;
  datalines;
Judge,Aaron,592450,2023,95.9,15.2,25.3,7.1,10.2,12.1,15.3,4.2,54.2,71.2,29.1,58.3,71.2,80.3,45.2,38.6,25.1,42.66,31.34,38.1,30.2,21.3,10.4,10.9
Ohtani,Shohei,660271,2023,94.2,13.8,22.1,6.8,11.5,13.2,14.8,3.9,53.1,66.4,32.5,60.1,73.5,79.8,44.1,32.5,40.2,35.15,24.65,44.5,28.6,19.8,7.1,6.9
Freeman,Freddie,518692,2023,91.5,12.1,12.5,9.2,12.8,10.5,13.2,3.1,60.2,72.3,45.2,64.5,80.1,83.2,47.5,20.3,38.5,34.15,27.35,41.2,25.5,26.8,6.5,6.6
Betts,Mookie,605141,2023,90.8,17.5,14.2,8.5,13.1,9.8,12.5,3.5,58.5,68.4,42.1,62.3,78.5,81.5,46.8,23.1,42.1,32.65,25.25,35.8,32.5,22.4,9.3,9.1
Alvarez,Yordan,670541,2023,93.7,11.2,20.8,7.9,10.5,11.2,15.8,4.5,55.8,70.1,35.2,59.8,72.1,80.8,45.5,29.8,36.8,36.25,26.95,39.5,29.8,20.1,10.6,10.4
Trout,Mike,545361,2023,92.1,16.8,18.5,8.1,11.8,12.5,13.5,4.1,52.5,64.2,38.5,55.2,70.8,78.5,43.2,27.5,44.5,30.25,25.25,36.5,33.2,20.5,9.8,9.6
Goldschmidt,Paul,502671,2023,90.2,14.5,13.8,9.5,12.2,10.8,14.1,3.8,57.8,69.5,40.5,61.2,76.5,80.2,46.1,25.2,39.8,33.5,26.7,40.2,26.8,23.1,9.9,9.6
Arraez,Luis,650333,2023,87.5,8.2,5.1,10.5,14.5,8.5,11.2,2.5,65.2,75.8,55.2,68.5,84.2,86.5,48.5,12.5,35.2,38.5,26.3,42.5,20.5,29.5,7.5,7.3
Semien,Marcus,543760,2023,89.8,13.2,10.5,8.8,12.5,11.5,13.8,3.6,56.5,67.8,39.5,58.5,74.5,79.5,45.8,24.5,38.2,34.5,27.3,38.5,29.5,23.8,8.2,8.0
Ramirez,Jose,608070,2023,89.2,14.8,11.2,9.1,13.2,11.8,14.5,3.4,58.2,68.5,41.2,60.5,75.8,80.5,46.5,23.8,42.5,31.5,26.0,37.5,30.2,22.5,9.8,9.6
Bogaerts,Xander,593428,2023,88.5,11.5,9.8,9.8,13.8,10.2,13.5,3.2,59.5,70.2,43.5,62.5,77.5,81.8,47.2,21.5,37.8,35.2,27.0,39.8,27.5,24.2,8.5,8.3
Devers,Rafael,646240,2023,92.5,13.5,17.2,8.2,11.2,12.8,14.2,4.3,54.5,66.8,36.8,57.2,71.5,79.2,44.5,28.5,40.5,33.5,26.0,37.2,31.5,21.8,9.5,9.3
;
run;

DATA BASEBALL; *renaming vars for simplicity;
RENAME exit_velocity_avg=AvergaeExitVelocity
launch_angle_avg=AverageLaunchAngle
barrel_batted_rate=BarrelBattedRate
solidcontact_percent=SolidContactPct
flareburner_percent=FlareBurnerPct
poorlyunder_percent=PoorlyUnderPct
poorlytopped_percent=PoorlyToppedPct
poorlyweak_percent=PoorlyWeakPct
hard_hit_percent=HardHitPct
z_swing_percent=ZSwingPct
oz_swing_percent=OZSwingPct
oz_contact_percent=OZContactPct
out_zone_percent=OutZonePct
iz_contact_percent=IZContactPct
in_zone_percent=InZonePct
edge_percent=EdgePct
whiff_percent=WhiffPct
pull_percent=PullPct
straightaway_percent=StraightAwayPct
opposite_percent=OppositePct
groundballs_percent=GroundballsPct
flyballs_percent=FlyballsPct
linedrives_percent=LinedrivesPct
popups_percent=PopupsPct;
SET BASEBALL;
full_name=cat(first_name,' ', last_name);
RUN;

*Cleaning up data set;
DATA BASEBALL;
	set BASEBALL (drop = last_name first_name player_id year);
RUN;

/******** Correlation Matrix *******/
proc corr data=BASEBALL;
run;
