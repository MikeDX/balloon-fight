//------------------------------------------------------------------------------
// Balloon Fight
// Autor: groovygecko
// Fecha: 03/06/03 (00:15:38h)
//------------------------------------------------------------------------------
program balloon_fight;
global
 file1;mapfile1;mapfile2;;nmefile1;nmefile2;nmefile3;
 font1;font2;font3;
 i;
 balloon1_id;balloon2_id;bolt_id;
 man_id;nme1_id;nme2_id;nme3_id;nme4_id;nme5_id;nme6_id;
 phase_text;bonus_text;what_text;

 s_level_intro;
 s_player_fly;
 s_balloon_pop;
 s_para_pop;
 s_splash;
 s_bubble_pop;
 s_lightning;
 s_player_die;
 s_electrocute;
 s_gameover;
 s_bonus_song;
 s_win_round;

 balloon_graph;
 balloons=2;
 level;
 cheese=0;
 p1_score=0;
 hi_score;
 p1_lives=2;
 fifth_zero;
 fourth_zero;
 third_zero;
 second_zero;
 first_zero;
 h_fifth_zero;
 h_fourth_zero;
 h_third_zero;
 h_second_zero;
 h_first_zero;
 number_of_enemies;
 number_of_balloons=20;
 menu_choice;
 bonus_balloon_x[3]=100,220,420,540;
 rand_levels[11]=1,2,3,5,6,7,9,10,11,13,14,15;
 hardness_map;
 what_map_file;
 what_phase=1;
 what_bonus=1;
 go_random=false;
local
 spin=false;

 vert_gravity=0;
 hori_gravity=0;
 temp_hori_gravity;

 nme1_score1;nme1_score2;nme1_score3;
 nme2_score1;nme2_score2;nme2_score3;
 nme3_score1;nme3_score2;nme3_score3;
 nme4_score1;nme4_score2;nme4_score3;
 nme5_score1;nme5_score2;nme5_score3;
 nme6_score1;nme6_score2;nme6_score3;

 min_speed;
 max_speed;
 nme_up1;
 nme_up2;
 nme_down1;
 nme_down2;

 nme1_vert_gravity;
 nme1_hori_gravity;
 nme1_temp_hori_gravity;
 nme1_stun_enemy=false;
 nme1_kill_enemy=false;
 nme1_flying=false;

 nme2_vert_gravity;
 nme2_hori_gravity;
 nme2_temp_hori_gravity;
 nme2_stun_enemy=false;
 nme2_kill_enemy=false;
 nme2_flying=false;

 nme3_vert_gravity;
 nme3_hori_gravity;
 nme3_temp_hori_gravity;
 nme3_stun_enemy=false;
 nme3_kill_enemy=false;
 nme3_flying=false;

 nme4_vert_gravity;
 nme4_hori_gravity;
 nme4_temp_hori_gravity;
 nme4_stun_enemy=false;
 nme4_kill_enemy=false;
 nme4_flying=false;

 nme5_vert_gravity;
 nme5_hori_gravity;
 nme5_temp_hori_gravity;
 nme5_stun_enemy=false;
 nme5_kill_enemy=false;
 nme5_flying=false;

 nme6_vert_gravity;
 nme6_hori_gravity;
 nme6_temp_hori_gravity;
 nme6_stun_enemy=false;
 nme6_kill_enemy=false;
 nme6_flying=false;

 flying=true;
 active=false;

 begin

 //full_screen=false;

 file1=load_fpg("fpg/balloon.fpg");

 mapfile1=load_fpg("fpg/ball_map.fpg");
 mapfile2=load_fpg("fpg/bal_map2.fpg"):

 nmefile1=load_fpg("fpg/ball_nme.fpg");
 nmefile2=load_fpg("fpg/bal_nme2.fpg");
 nmefile3=load_fpg("fpg/bal_nme3.fpg");

 font1=load_fnt("fnt/player1.fnt");
 font2=load_fnt("fnt/score.fnt");
 font3=load_fnt("fnt/hi_score.fnt");

 s_level_intro=load_pcm("pcm/l_int.wav",0);
 s_player_fly=load_pcm("pcm/p_fly.wav",0);
 s_balloon_pop=load_pcm("pcm/b_pop1.wav",0);
 s_para_pop=load_pcm("pcm/para.wav",0);
 s_splash=load_pcm("pcm/splash.wav",0);
 s_bubble_pop=load_pcm("pcm/bubble.wav",0);
 s_lightning=load_pcm("pcm/fork.wav",0);
 s_player_die=load_pcm("pcm/p_die.wav",0);
 s_electrocute=load_pcm("pcm/elec.wav",0);
 s_gameover=load_pcm("pcm/gameover.wav",0);
 s_bonus_song=load_pcm("pcm/bonus.wav",0);
 s_win_round=load_pcm("pcm/winround.wav",0);

 set_mode(m640x480);
 set_fps(30,0);

 load("dat\hi_score.dat",&hi_score);

 text_z=2500;

  intro();
  loop
  frame;
 end
end

process intro();
private
begin
 put_screen(file1,610);
 timer[0]=0;
  loop
   if(timer[0]>1000 or key(_space))
   break;end
  frame;
 end
 fade_off();
  clear_screen();
  delete_text(all_text);
  //stop_sound(all_sound);
  let_me_alone();
  menu_screen();
  fade_on();
end


process menu_screen();
private
begin
 cheese=0;
 p1_score=0;
 p1_lives=2;
 balloons=2;
 number_of_balloons=20;
 what_phase=1;
 what_bonus=1;
 go_random=false;

 put_screen(file1,600);
 cursor();
  loop

  if(key(_esc))exit("bye",0);end

   if(key(_enter))
   break;end

  frame;
 end
  fade_off();
  clear_screen();
  delete_text(all_text);
  //stop_sound(all_sound);
  let_me_alone();
  if(menu_choice==1)levels(1);end
  if(menu_choice==2)credits();end
  if(menu_choice==3)exit("Thanks for Playing",0);end
  fade_on();
end

process cursor();
private
 balloon_counter;
begin
 file=file1;
 graph=601;
 x=115;
 y=290;
  loop
   balloon_counter++;

   if(balloon_counter>2)
    balloon_counter=0;graph++;
   end

   if(graph>608)
    graph=601;
   end

   if(key(_down) and y<360)
    y+=35;
     repeat
      cheese+=1;
      frame;
      until(cheese>5)
      cheese=0;
   end

   if(key(_up) and y>290)
    y-=35;
     repeat
      cheese+=1;
      frame;
      until(cheese>5)
      cheese=0;
   end

   if(y==290)
    menu_choice=1;
   end

   if(y==325)
    menu_choice=2;;
   end

   if(y==360);
    menu_choice=3;
   end
  frame;
 end
end

process credits():
private
begin
 put_screen(file1,611);
  loop
   if(key(_space))
   break;end
  frame;
 end
 fade_off();
  clear_screen();
  delete_text(all_text);
  //stop_sound(all_sound);
  let_me_alone();
  menu_screen();
  fade_on();
end

process game_over();
private
begin
 timer[0]=0;
 write(font2,320,240,4,"GAME OVER");
 sound(s_gameover,256,256);

  loop
   if(timer[0]>200)
   break;end
  frame;
 end
 fade_off();
  clear_screen();
  delete_text(all_text);
  //stop_sound(all_sound);
  let_me_alone();
  menu_screen();
  fade_on();
end


process levels(whatlevel);
private
 text_counter=0;
 bonus_balloon_counter=0;
 change_bonus_level;
begin
  write(font1,50,13,5,"I-");
  write(font3,300,10,5,"TOP-");

  if(level==4 or level==8 or level==12 or level==16)
   phase_text=write(font2,311,40,4,"BONUS-");
   what_text=write_int(font2,376,40,4,&what_bonus);
   sound(s_bonus_song,256,256);
  else phase_text=write(font2,311,40,4,"PHASE-");
       what_text=write_int(font2,376,40,4,&what_phase);
  end

  lives(140,33);
  number_of_balloons=20;

  //write(font1,
  fifth_zero=write(font2,70,13,5,"0");
  fourth_zero=write(font2,88,13,5,"0");
  third_zero=write(font2,106,13,5,"0");
  second_zero=write(font2,124,13,5,"0");
  first_zero=write(font2,142,13,5,"0");

  write_int(font2,160,13,5,&p1_score);


  h_fifth_zero=write(font2,318,10,5,"0");
  h_fourth_zero=write(font2,336,10,5,"0");
  h_third_zero=write(font2,354,10,5,"0");
  h_second_zero=write(font2,372,10,5,"0");
  h_first_zero=write(font2,390,10,5,"0");

  write_int(font2,408,10,5,&hi_score);

  if(whatlevel==1)
   what_map_file=mapfile1;

   put_screen(what_map_file,1);

   number_of_enemies=3;
   hardness_map=2;

   sound(s_level_intro,256,256);
   //sound(s_level_intro,256,256);

   man_id=man(95,412);

   nme1_id=enemy1(1,215,280,nmefile1,210);
   nme2_id=enemy2(1,315,280,nmefile1,210);
   nme3_id=enemy3(1,415,280,nmefile1,210);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),1);
   end

   sea(320,459);
   cloud(360,115);

   //phase_text=write(font2,320,40,4,"PHASE-01");

  end

  if(whatlevel==2)
   what_map_file=mapfile1;
   put_screen(what_map_file,3);

   number_of_enemies=5;
   hardness_map=4;

   man_id=man(95,412);

   nme1_id=enemy1(1,215,280,nmefile1,210);
   nme2_id=enemy2(1,315,280,nmefile1,210);
   nme3_id=enemy3(1,415,280,nmefile1,210);
   //nme4_id=enemy4(2,160,165,nmefile2,211);
   nme4_id=enemy4(2,160,165,nmefile2,211);
   nme5_id=enemy5(2,520,149,nmefile2,211);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),1);
   end

   sea(320,459);

   cloud(120,250);
   cloud(520,215);

   //phase_text=write(font2,320,40,4,"PHASE-02");

  end

  if(whatlevel==3)
   what_map_file=mapfile1;
   put_screen(what_map_file,5);

   number_of_enemies=5;
   hardness_map=6;

   man_id=man(95,412);

   nme1_id=enemy1(1,320,365,nmefile1,210);
   nme2_id=enemy2(2,190,265,nmefile2,211);
   nme3_id=enemy3(2,350,180,nmefile2,211);
   nme4_id=enemy4(3,220,100,nmefile3,212);
   nme5_id=enemy5(3,530,100,nmefile3,212);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),1);
   end

   sea(320,459);

   cloud(120,150);
   cloud(480,280);

   //phase_text=write(font2,320,40,4,"PHASE-03");

  end

  if(level==4)
   what_map_file=mapfile1;
   put_screen(what_map_file,500);

   hardness_map=501;
   number_of_enemies=5;

   man_id=man(50,412);

   pipes(319,404,700);

   from i=0 to 100;
    stars(rand(0,640),rand(0,480),2);
   end

   //phase_text=write(font2,320,40,4,"BONUS-01");
  end

  if(whatlevel==5)
   what_map_file=mapfile1;
   put_screen(what_map_file,7);

   number_of_enemies=5;
   hardness_map=8;
   balloons=2;

   man_id=man(95,412);

   nme1_id=enemy1(3,390,365,nmefile3,212);
   nme2_id=enemy2(1,150,265,nmefile1,210);
   nme3_id=enemy3(1,270,300,nmefile1,210);
   nme4_id=enemy4(1,490,280,nmefile1,210);
   nme5_id=enemy5(2,350,180,nmefile2,211);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),3);
   end

   sea(320,459);

   cloud(200,120);
   cloud(520,185);

   //phase_text=write(font2,320,40,4,"PHASE-04");

  end

  if(whatlevel==6)
   what_map_file=mapfile1;
   put_screen(what_map_file,9);

   number_of_enemies=6;
   hardness_map=10;

   man_id=man(95,412);

   nme1_id=enemy1(1,230,330,nmefile1,210);
   nme2_id=enemy2(1,410,330,nmefile1,210);
   nme3_id=enemy3(2,110,200,nmefile2,211);
   nme4_id=enemy4(2,270,165,nmefile2,211);
   nme5_id=enemy5(2,510,150,nmefile2,211);
   nme6_id=enemy6(3,250,80,nmefile3,212);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),3);
   end

   sea(320,459);

   cloud(120,115);
   cloud(400,150);

   //phase_text=write(font2,320,40,4,"PHASE-05");

  end

  if(whatlevel==7)
   what_map_file=mapfile1;
   put_screen(what_map_file,11);

   number_of_enemies=5;
   hardness_map=12;

   man_id=man(95,412);

   nme1_id=enemy1(1,300,300,nmefile1,210);
   nme2_id=enemy2(3,110,200,nmefile3,212);
   nme3_id=enemy3(3,530,200,nmefile3,212);
   nme4_id=enemy4(3,200,115,nmefile3,212);
   nme5_id=enemy5(3,440,115,nmefile3,212);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),3);
   end

   sea(320,459);

   cloud(320,120);
   cloud(280,350);

   //phase_text=write(font2,320,40,4,"PHASE-06");

  end

  if(level==8)
   what_map_file=mapfile1;
   put_screen(what_map_file,502);

   hardness_map=503;
   number_of_enemies=5;
   balloons=2;

   man_id=man(50,412);

   pipes(319,404,700);

   from i=0 to 100;
    stars(rand(0,640),rand(0,480),1);
   end

   //phase_text=write(font2,320,40,4,"BONUS-02");
  end

  if(whatlevel==9)
   what_map_file=mapfile2;
   put_screen(what_map_file,1);

   number_of_enemies=6;
   hardness_map=2;

   man_id=man(95,412);

   nme1_id=enemy1(1,160,280,nmefile1,210);
   nme2_id=enemy2(2,240,250,nmefile2,211);
   nme3_id=enemy3(2,400,180,nmefile2,211);
   nme4_id=enemy4(2,480,150,nmefile2,211);
   nme5_id=enemy5(3,560,100,nmefile3,212);
   nme6_id=enemy6(3,60,100,nmefile3,212);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),3);
   end

   sea(320,459);

   spinner(330,224,800,0);

   cloud(160,115);
   cloud(440,285);

   //phase_text=write(font2,320,40,4,"PHASE-07");

  end

  if(whatlevel==10)
   what_map_file=mapfile2;
   put_screen(what_map_file,3);

   number_of_enemies=6;
   hardness_map=4;

   man_id=man(95,412);

   nme1_id=enemy1(1,250,300,nmefile1,210);
   nme2_id=enemy2(1,390,300,nmefile1,210);
   nme3_id=enemy3(2,200,200,nmefile2,211);
   nme4_id=enemy4(2,460,200,nmefile2,211);
   nme5_id=enemy5(3,120,100,nmefile3,212);
   nme6_id=enemy6(3,520,100,nmefile3,212);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),3);
   end

   sea(320,459);
   spinner(310,105,800,0);

   cloud(120,280);
   cloud(520,280);

   //phase_text=write(font2,320,40,4,"PHASE-08");

  end

  if(whatlevel==11)
   what_map_file=mapfile2;
   put_screen(what_map_file,5);

   number_of_enemies=5;
   hardness_map=6;

   man_id=man(95,412);

   nme1_id=enemy1(3,390,365,nmefile3,212);
   nme2_id=enemy2(1,150,265,nmefile1,210);
   nme3_id=enemy3(1,270,295,nmefile1,210);
   nme4_id=enemy4(1,490,280,nmefile1,210);
   nme5_id=enemy5(2,350,180,nmefile2,211);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),3);
   end

   sea(320,459);
   spinner(190,140,800,0);
   spinner(510,75,800,0);

   cloud(360,115);
   cloud(560,215);

   //phase_text=write(font2,320,40,4,"PHASE-09");

  end

  if(level==12)
   what_map_file=mapfile2;
   put_screen(what_map_file,500);

   hardness_map=501;
   number_of_enemies=5;
   balloons=2;

   man_id=man(50,412);

   pipes(319,404,700);

   from i=0 to 100;
    stars(rand(0,640),rand(0,480),1);
   end

   //phase_text=write(font2,320,40,4,"BONUS-03");
  end

   if(whatlevel==13)
   what_map_file=mapfile2;
   put_screen(what_map_file,7);

   number_of_enemies=5;
   hardness_map=8;

   man_id=man(95,412);

   nme1_id=enemy1(2,230,350,nmefile2,211);
   nme2_id=enemy2(2,390,350,nmefile2,211);
   nme3_id=enemy3(3,290,145,nmefile3,212);
   nme4_id=enemy4(3,390,130,nmefile3,212);
   nme5_id=enemy5(3,490,210,nmefile3,212);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),4);
   end

   sea(320,459);
   spinner(190,240,800,90000);
   spinner(290,155,800,90000);
   spinner(390,140,800,90000);
   spinner(490,220,800,90000);

   cloud(120,120);
   cloud(360,250);

   //phase_text=write(font2,320,40,4,"PHASE-10");

  end

  if(whatlevel==14)
   what_map_file=mapfile2;
   put_screen(what_map_file,9);

   number_of_enemies=6;
   hardness_map=10;

   man_id=man(95,412);

   nme1_id=enemy1(1,100,300,nmefile1,210);
   nme2_id=enemy2(1,580,300,nmefile1,210);
   nme3_id=enemy3(2,180,250,nmefile2,211);
   nme4_id=enemy4(2,500,250,nmefile2,211);
   nme5_id=enemy5(3,260,200,nmefile3,212);
   nme6_id=enemy6(3,420,200,nmefile3,212);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),4);
   end

   sea(320,459);
   spinner(350,125,800,0);

   cloud(120,150);
   cloud(320,280);

   //phase_text=write(font2,320,40,4,"PHASE-11");

  end

  if(whatlevel==15)
   what_map_file=mapfile2;
   put_screen(what_map_file,11);

   number_of_enemies=6;
   hardness_map=12;

   man_id=man(95,412);

   nme1_id=enemy1(2,240,290,nmefile2,211);
   nme2_id=enemy2(2,380,290,nmefile2,211);
   nme3_id=enemy3(3,80,190,nmefile3,212);
   nme4_id=enemy4(3,560,190,nmefile3,212);
   nme5_id=enemy5(3,240,90,nmefile3,212);
   nme6_id=enemy6(3,380,90,nmefile3,212);

   from i=0 to 100;
    stars(rand(0,640),rand(0,400),4);
   end

   sea(320,459);
   spinner(315,200,800,0);

   cloud(100,90);
   cloud(540,300);

   //phase_text=write(font2,320,40,4,"PHASE-12");

  end

   if(level==16)
   what_map_file=mapfile2;
   put_screen(what_map_file,500);

   hardness_map=501;
   number_of_enemies=5;
   balloons=2;

   man_id=man(50,412);

   pipes(319,404,700);

   from i=0 to 100;
    stars(rand(0,640),rand(0,480),1);
   end

   //phase_text=write(font2,320,40,4,"BONUS-03");
  end


   loop
     text_counter++;

     if(text_counter>100)
      delete_text(phase_text);
      delete_text(what_text);
     end

     if(p1_score>hi_score)
      hi_score=p1_score;
      save("c:\div2\dat\hi_score.dat",&hi_score,sizeof(hi_score));
     end

    if(key(_esc))exit("bye",0);end

    if(p1_score>9)
     delete_text(first_zero);
    end

    if(p1_score>99)
     delete_text(second_zero);
    end

    if(p1_score>999)
     delete_text(third_zero);
    end

    if(p1_score>9999)
     delete_text(fourth_zero);
    end

    if(p1_score>99999)
     delete_text(fifth_zero);
    end

    if(hi_score>9)
     delete_text(h_first_zero);
    end

    if(hi_score>99)
     delete_text(h_second_zero);
    end

    if(hi_score>999)
     delete_text(h_third_zero);
    end

    if(hi_score>9999)
     delete_text(h_fourth_zero);
    end

    if(hi_score>99999)
     delete_text(h_fifth_zero);
    end

     if(whatlevel==1)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
        if(go_random==false)
         level=2;
         else level=rand_levels[rand(0,11)];
        end
        break;
      end
     end

     if(whatlevel==2)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
        if(go_random==false)
         level=3;
        else level=rand_levels[rand(0,11)];
        end
         break;
      end
     end

     if(whatlevel==3)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
        if(go_random==false)
         level=4;
        else level=rand_levels[rand(0,11)];
        end
        break;
      end
     end

     if(whatlevel==4);
      if(number_of_balloons>0)
       bonus_balloon_counter++;
        if(bonus_balloon_counter>rand(35,50))
         bonus_balloon(bonus_balloon_x[rand(0,3)],440);
         bonus_balloon_counter=0;
         number_of_balloons-=1;
        end
       end
       if(number_of_balloons==0)
        change_bonus_level++;
        if(change_bonus_level>250)
         if(go_random==false)
            level=5;
          else level=rand_levels[rand(0,11)];
         end
         what_bonus+=1;change_bonus_level=0;
        break;end
       end
     end

     if(whatlevel==5)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
       if(go_random==false)
         level=6;
        else level=rand_levels[rand(0,11)];
        end
       break;
      end
     end


     if(whatlevel==6)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
        if(go_random==false)
         level=7;
        else level=rand_levels[rand(0,11)];
        end
       break;
      end
     end

    if(whatlevel==7)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
        if(go_random==false)
         level=8;
        else level=rand_levels[rand(0,11)];
        end
       break;
      end
     end

    if(whatlevel==8);
      if(number_of_balloons>0)
       bonus_balloon_counter++;
        if(bonus_balloon_counter>rand(35,50))
         bonus_balloon(bonus_balloon_x[rand(0,3)],440);
         bonus_balloon_counter=0;
         number_of_balloons-=1;
        end
       end
       if(number_of_balloons==0)
        change_bonus_level++;
        if(change_bonus_level>250)
         if(go_random==false)
            level=9;
          else level=rand_levels[rand(0,11)];
         end
         what_bonus+=1;change_bonus_level=0;
        break;end
       end
     end

    if(whatlevel==9)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
       if(go_random==false)
         level=10;
        else level=rand_levels[rand(0,11)];
        end
       break;
      end
     end

     if(whatlevel==10)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
        if(go_random==false)
         level=11;
        else level=rand_levels[rand(0,11)];
        end
       break;
      end
     end

     if(whatlevel==11)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
       if(go_random==false)
         level=12;
        else level=rand_levels[rand(0,11)];
        end
       break;
      end
     end

     if(whatlevel==12);
      if(number_of_balloons>0)
       bonus_balloon_counter++;
        if(bonus_balloon_counter>rand(35,50))
         bonus_balloon(bonus_balloon_x[rand(0,3)],440);
         bonus_balloon_counter=0;
         number_of_balloons-=1;
        end
       end
       if(number_of_balloons==0)
        change_bonus_level++;
        if(change_bonus_level>250)
         if(go_random==false)
            level=13;
          else level=rand_levels[rand(0,11)];
         end
         what_bonus+=1;change_bonus_level=0;
        break;end
       end
     end

     if(whatlevel==13)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
       if(go_random==false)
         level=14;
        else level=rand_levels[rand(0,11)];
        end
       break;
      end
     end

     if(whatlevel==14)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
        if(go_random==false)
         level=15;
        else level=rand_levels[rand(0,11)];
        end
       break;
      end
     end

     if(whatlevel==15)
      if(number_of_enemies==0)
        what_phase+=1;sound(s_win_round,256,256);
        if(go_random==false)
         level=16;
        else level=rand_levels[rand(0,11)];
        end
        break;
      end
     end

     if(whatlevel==16);
      if(number_of_balloons>0)
       bonus_balloon_counter++;
        if(bonus_balloon_counter>rand(35,50))
         bonus_balloon(bonus_balloon_x[rand(0,3)],440);
         bonus_balloon_counter=0;
         number_of_balloons-=1;
        end
       end
       if(number_of_balloons==0)
        change_bonus_level++;
        if(change_bonus_level>250)
          level=rand_levels[rand(0,11)];
          go_random=true;
         what_bonus+=1;change_bonus_level=0;
        break;end
       end
     end

  frame;
 end
  fade_off();
  clear_screen();
  delete_text(all_text);
  //stop_sound(all_sound);
  let_me_alone();
  levels(level);
  fade_on();
end


process man(x,y);
private
 temp_dist;                                       //holds a temporay distance
 temp_inc;
 yellow_collision;                                //temporary increment value
 sliding_counter;                                 //counter for sliding
 gravity_counter;
 put_nme1_score=false;
 put_nme2_score=false;
 put_nme3_score=false;
 put_nme4_score=false;
 put_nme5_score=false;
 put_nme6_score=false;
 graph_counter=0;still_graph;
 fall_gravity=-10;
 electrocute_counter=0;
 electrocute=false;
 bolt_id_code;
 hard_colour;                                  //storecolour of hardnessmap
 side_collision=false;
 ctr=0;     //temporary counter
 nme1_balloon_col;
 nme1_parasol_col;
 nme2_balloon_col;
 nme2_parasol_col;
 nme3_balloon_col;
 nme3_parasol_col;
 nme4_balloon_col;
 nme4_parasol_col;
 nme5_balloon_col;
 nme5_parasol_col;
 nme6_balloon_col;
 nme6_parasol_col;
 spinner_col;
 play_fly_sound=5;
begin
 file=file1;
 graph=1;

 flags=1;

 if(balloons==1)
  balloon1_id=balloon(0,3,100,1);
 end
 if(balloons==2)
  balloon1_id=balloon(0,3,100,1);
  balloon2_id=balloon(1,-3,50,0);
 end
 //balloons=2;
  loop

    if(active==false)
     graph_counter++;

     if(graph_counter<5)
      still_graph=1;balloon_graph=200;
     end

     if(graph_counter>10)
      still_graph=10;balloon_graph=205;
     end

     if(graph_counter>20)
      graph_counter=0;
     end

     if(key(_right) or key(_left) or key(_x))
      active=true;balloon_graph=200;
     end
    end

    if(active==true);
     still_graph=1;
    end

     gravity_counter++;
      if(gravity_counter>1)
       gravity_counter=0;vert_gravity--;
      end


    if(vert_gravity!=0)
     temp_dist = vert_gravity;                    //save the distance to move

    temp_inc = vert_gravity / abs(vert_gravity);  //is it plus or minus 1!!!

    for( ; temp_dist != 0; temp_dist-= temp_inc)  //go through each point 1 to at most 6

       if(map_get_pixel(what_map_file,hardness_map,x/2,(y-temp_inc)/2)!=22)
                                                   //check next point for collision
         flying=true;                                         //if no collision
         y-=temp_inc;         //move y value


        /////////////////////////////////////////
// changed code here
// noneed for adding temp_inc aswe'vealready moved
/////////////////////////////////////////
                    if(map_get_pixel(what_map_file,hardness_map,x/2,(y-49)/2)==54)
                        y+=vert_gravity;
                        vert_gravity=-vert_gravity;
                    end
/////////////////////////////////////////
// end of changed code
/////////////////////////////////////////


       else                                        //there is a collision
        flying=false;                           //break out of loop or bounce down/up
        vert_gravity = 0;
        if(hori_gravity==0)graph=still_graph;end
        sliding_counter++;

        if(hori_gravity>0 and sliding_counter>1)
         sliding_counter=0;hori_gravity--;
          if(not key(_right))
           graph=5;
          end
        end

        if(hori_gravity<0 and sliding_counter>1)
         sliding_counter=0;hori_gravity++;
          if(not key(_left))                                                              //
           graph=5;
          end
        end                                                                                     //        v

        if(key(_right))
         hori_gravity++;
         graph++;
         if(graph<6 or graph>9)graph=6;end
        end

        if(key(_left))
         hori_gravity--;;
         graph++;
         if(graph<6 or graph>9)graph=6;end
        end
       end

    end
   end

   /*if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==73)
    temp_hori_gravity=hori_gravity-(hori_gravity*2);
    hori_gravity=temp_hori_gravity;
   end

   if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==41)
    temp_hori_gravity=hori_gravity+(hori_gravity*2);
    hori_gravity=temp_hori_gravity;
   end*/

   ///////////////////////////////////////////////////////////////////////////////
/////////////////////////START/OF/NEW CODE/////////////////////////////////////
//////////////////Controls/horizontal/collision/and/movement///////////////////
///////////////////////////////////////////////////////////////////////////////


        //notes : horizontal flying map is 30 pixels wide soadd15 to check
        //        map is.24 pixels.high.with control.point.at.bottom
        //        balloon.is.24.pixels.high.so.check.48.pixels.altogether

        if( hori_gravity != 0 )                   //if the man is moving then check
            temp_dist = hori_gravity;             //savethe distance tomove
            temp_inc = hori_gravity / abs( hori_gravity );//gettheincrement + or- 1

            for(; temp_dist != 0; temp_dist-= temp_inc)  //gothrougheachnewposition


                for( ctr =0; ctr<48; ctr++ )         //check.each.point.at.side.of.map
                    hard_colour = map_get_pixel(what_map_file,hardness_map,(x+temp_inc+temp_inc*15)/2,(y-ctr)/2);
                    if( (hard_colour == 73) or (hard_colour == 41) )
                        side_collision = true;
                    end
                end

                if( side_collision ==false)
                   x+=temp_inc;
                else
                   x-=temp_inc*6;   //bounceback
                   hori_gravity = -hori_gravity;  //changedirection

                  //wallis hit
                end
                if( x<0 ) x=640;end
                if( x>640 ) x=0;end
                //reset collisionvariable
                side_collision = false;
            end
        end

///////////////////////////////////////////////////////////////////////////////
///////////////////////////END/OF/NEW CODE/////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

   if(vert_gravity<-6)vert_gravity=-6;end
   if(vert_gravity>6)vert_gravity=6;end
   if(hori_gravity<-6)hori_gravity=-6;end
   if(hori_gravity>6)hori_gravity=6;end
   if(key(_right))flags=1;end
   if(key(_left))flags=0;end
   //if(x<0)x=640;end
   //if(x>640)x=0;end
   if(y<40)vert_gravity-=8;end

   spinner_col=collision(type spinner);

   if(spinner_col!=0)
    spinner_col.spin=true;
    vert_gravity+=rand(-6,6);
    hori_gravity+=rand(-6,6);
   end

   if(key(_x))
    graph++;
    play_fly_sound++;
    if(play_fly_sound>4)
     sound(s_player_fly,256,256);
     play_fly_sound=0;
    end

     if(graph>3)
      graph=2;
     end

    vert_gravity+=2;

   if(key(_right))
    hori_gravity++;
   end

   if(key(_left))
    hori_gravity--;
   end

    //x+=hori_gravity;
   end

   if(not key(_x))
    //x+=hori_gravity;
     play_fly_sound=5;
     if(vert_gravity!=0)
      graph=4;
     end
   end

   if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==59);
    splash(x,y-55);
   break;end

   bolt_id_code=collision(type bolt);

   if(active==true)

    nme1_balloon_col=collision(type nme1_balloon);
    nme1_parasol_col=collision(type nme1_parasol);

    nme2_balloon_col=collision(type nme2_balloon);
    nme2_parasol_col=collision(type nme2_parasol);

    nme3_balloon_col=collision(type nme3_balloon);
    nme3_parasol_col=collision(type nme3_parasol);

    nme4_balloon_col=collision(type nme4_balloon);
    nme4_parasol_col=collision(type nme4_parasol);

    nme5_balloon_col=collision(type nme5_balloon);
    nme5_parasol_col=collision(type nme5_parasol);

    nme6_balloon_col=collision(type nme6_balloon);
    nme6_parasol_col=collision(type nme6_parasol);


    if(nme1_balloon_col!=0)
     signal(nme1_balloon_col,s_kill);
     nme1_id.nme1_stun_enemy=true;
     vert_gravity+=10;p1_score+=nme1_id.nme1_score1;
     sound(s_balloon_pop,256,256);
    end

    if(nme1_parasol_col!=0)
     signal(nme1_parasol_col,s_kill);
     nme1_id.nme1_kill_enemy=true;
     vert_gravity+=10;p1_score+=nme1_id.nme1_score3;
     sound(s_para_pop,256,256);
     put_nme1_score=true;
    end

    if(nme2_balloon_col!=0)
     signal(nme2_balloon_col,s_kill);
     nme2_id.nme2_stun_enemy=true;
     vert_gravity+=10;p1_score+=nme2_id.nme2_score1;
     sound(s_balloon_pop,256,256);
    end

    if(nme2_parasol_col!=0)
     signal(nme2_parasol_col,s_kill);
     nme2_id.nme2_kill_enemy=true;
     vert_gravity+=10;p1_score+=nme2_id.nme2_score3;
     sound(s_para_pop,256,256);
     put_nme2_score=true;
    end

    if(nme3_balloon_col!=0)
     signal(nme3_balloon_col,s_kill);
     nme3_id.nme3_stun_enemy=true;
     vert_gravity+=10;p1_score+=nme3_id.nme3_score1;
     sound(s_balloon_pop,256,256);
    end

    if(nme3_parasol_col!=0)
     signal(nme3_parasol_col,s_kill);
     nme3_id.nme3_kill_enemy=true;
     vert_gravity+=10;p1_score+=nme3_id.nme3_score3;
     sound(s_para_pop,256,256);
     put_nme3_score=true;
    end

   if(nme4_balloon_col!=0)
     signal(nme4_balloon_col,s_kill);
     nme4_id.nme4_stun_enemy=true;
     vert_gravity+=10;p1_score+=nme4_id.nme4_score1;
     sound(s_balloon_pop,256,256);
    end

   if(nme4_parasol_col!=0)
     signal(nme4_parasol_col,s_kill);
     nme4_id.nme4_kill_enemy=true;
     vert_gravity+=10;p1_score+=nme4_id.nme4_score3;
     sound(s_para_pop,256,256);
     put_nme4_score=true;
    end

   if(nme5_balloon_col!=0)
     signal(nme5_balloon_col,s_kill);
     nme5_id.nme5_stun_enemy=true;
     vert_gravity+=10;p1_score+=nme5_id.nme5_score1;
     sound(s_balloon_pop,256,256);
    end

    if(nme5_parasol_col!=0)
     signal(nme5_parasol_col,s_kill);
     nme5_id.nme5_kill_enemy=true;
     vert_gravity+=10;p1_score+=nme5_id.nme5_score3;
     sound(s_para_pop,256,256);
     put_nme5_score=true;
    end

   if(nme6_balloon_col!=0)
     signal(nme6_balloon_col,s_kill);
     nme6_id.nme6_stun_enemy=true;
     vert_gravity+=10;p1_score+=nme6_id.nme6_score1;
     sound(s_balloon_pop,256,256);
    end

    if(nme6_parasol_col!=0)
     signal(nme6_parasol_col,s_kill);
     nme6_id.nme6_kill_enemy=true;
     vert_gravity+=10;p1_score+=nme6_id.nme6_score3;
     sound(s_para_pop,256,256);
     put_nme6_score=true;
    end

    if(collision(type enemy1))
     if(nme1_id.nme1_flying==true and nme1_id.nme1_kill_enemy==false)

      if(hori_gravity>0)
       temp_hori_gravity=hori_gravity-(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme1_id.nme1_temp_hori_gravity=nme1_id.nme1_hori_gravity+(nme1_id.nme1_hori_gravity*2);
       nme1_id.nme1_hori_gravity=nme1_id.nme1_temp_hori_gravity;

       //nme1_id.nme1_hori_gravity+=12;
      end
      if(hori_gravity<0)
       temp_hori_gravity=hori_gravity+(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme1_id.nme1_temp_hori_gravity=nme1_id.nme1_hori_gravity-(nme1_id.nme1_hori_gravity*2);
       nme1_id.nme1_hori_gravity=nme1_id.nme1_temp_hori_gravity;

       //nme1_id.nme1_hori_gravity-=12;

      end
     end

     if(nme1_id.nme1_flying==false)
        if(put_nme1_score==false)
         sound(s_para_pop,256,256);
         put_nme1_score=true;
         p1_score+=nme1_id.nme1_score2;
        end
        nme1_id.nme1_kill_enemy=true;

       end

    end


     if(collision(type enemy2))
     if(nme2_id.nme2_flying==true and nme2_id.nme2_kill_enemy==false)

      if(hori_gravity>0)
       temp_hori_gravity=hori_gravity-(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme2_id.nme2_temp_hori_gravity=nme2_id.nme2_hori_gravity+(nme2_id.nme2_hori_gravity*2);
       nme2_id.nme2_hori_gravity=nme2_id.nme2_temp_hori_gravity;

       //nme2_id.nme2_hori_gravity+=12;
      end
      if(hori_gravity<0)
       temp_hori_gravity=hori_gravity+(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme2_id.nme2_temp_hori_gravity=nme2_id.nme2_hori_gravity-(nme2_id.nme2_hori_gravity*2);
       nme2_id.nme2_hori_gravity=nme2_id.nme2_temp_hori_gravity;

       //nme2_id.nme2_hori_gravity-=12;

      end
     end

      if(nme2_id.nme2_flying==false)
        if(put_nme2_score==false)
        sound(s_para_pop,256,256);
         put_nme2_score=true;
         p1_score+=nme2_id.nme2_score2;
        end
        nme2_id.nme2_kill_enemy=true;

       end

    end

    if(collision(type enemy3))
     if(nme3_id.nme3_flying==true and nme3_id.nme3_kill_enemy==false)

      if(hori_gravity>0)
       temp_hori_gravity=hori_gravity-(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme3_id.nme3_temp_hori_gravity=nme3_id.nme3_hori_gravity+(nme3_id.nme3_hori_gravity*2);
       nme3_id.nme3_hori_gravity=nme3_id.nme3_temp_hori_gravity;

       //nme3_id.nme3_hori_gravity+=12;
      end
      if(hori_gravity<0)
       temp_hori_gravity=hori_gravity+(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme3_id.nme3_temp_hori_gravity=nme3_id.nme3_hori_gravity-(nme3_id.nme3_hori_gravity*2);
       nme3_id.nme3_hori_gravity=nme3_id.nme3_temp_hori_gravity;

       //nme3_id.nme3_hori_gravity-=12;

      end
     end

      if(nme3_id.nme3_flying==false)
        if(put_nme3_score==false)
        sound(s_para_pop,256,256);
         put_nme3_score=true;
         p1_score+=nme3_id.nme3_score2;
        end
        nme3_id.nme3_kill_enemy=true;

       end

    end

   if(collision(type enemy4))
     if(nme4_id.nme4_flying==true and nme4_id.nme4_kill_enemy==false)

      if(hori_gravity>0)
       temp_hori_gravity=hori_gravity-(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme4_id.nme4_temp_hori_gravity=nme4_id.nme4_hori_gravity+(nme4_id.nme4_hori_gravity*2);
       nme4_id.nme4_hori_gravity=nme4_id.nme4_temp_hori_gravity;

       //nme4_id.nme4_hori_gravity+=12;
      end
      if(hori_gravity<0)
       temp_hori_gravity=hori_gravity+(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme4_id.nme4_temp_hori_gravity=nme4_id.nme4_hori_gravity-(nme4_id.nme4_hori_gravity*2);
       nme4_id.nme4_hori_gravity=nme4_id.nme4_temp_hori_gravity;

       //nme4_id.nme4_hori_gravity-=12;

      end
     end

      if(nme4_id.nme4_flying==false)
        if(put_nme4_score==false)
        sound(s_para_pop,256,256);
         put_nme4_score=true;
         p1_score+=nme4_id.nme4_score2;
        end
        nme4_id.nme4_kill_enemy=true;

       end

    end

   if(collision(type enemy5))
     if(nme5_id.nme5_flying==true and nme5_id.nme5_kill_enemy==false)

      if(hori_gravity>0)
       temp_hori_gravity=hori_gravity-(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme5_id.nme5_temp_hori_gravity=nme5_id.nme5_hori_gravity+(nme5_id.nme5_hori_gravity*2);
       nme5_id.nme5_hori_gravity=nme5_id.nme5_temp_hori_gravity;

       //nme5_id.nme5_hori_gravity+=12;
      end
      if(hori_gravity<0)
       temp_hori_gravity=hori_gravity+(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme5_id.nme5_temp_hori_gravity=nme5_id.nme5_hori_gravity-(nme5_id.nme5_hori_gravity*2);
       nme5_id.nme5_hori_gravity=nme5_id.nme5_temp_hori_gravity;

       //nme5_id.nme5_hori_gravity-=12;

      end
     end

      if(nme5_id.nme5_flying==false)
        if(put_nme5_score==false)
        sound(s_para_pop,256,256);
         put_nme5_score=true;
         p1_score+=nme5_id.nme5_score2;
        end
        nme5_id.nme5_kill_enemy=true;

       end

    end


   if(collision(type enemy6))
     if(nme6_id.nme6_flying==true and nme6_id.nme6_kill_enemy==false)

      if(hori_gravity>0)
       temp_hori_gravity=hori_gravity-(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme6_id.nme6_temp_hori_gravity=nme6_id.nme6_hori_gravity+(nme6_id.nme6_hori_gravity*2);
       nme6_id.nme6_hori_gravity=nme6_id.nme6_temp_hori_gravity;

       //nme6_id.nme6_hori_gravity+=12;
      end
      if(hori_gravity<0)
       temp_hori_gravity=hori_gravity+(hori_gravity*2);
       hori_gravity=temp_hori_gravity;

       nme6_id.nme6_temp_hori_gravity=nme6_id.nme6_hori_gravity-(nme6_id.nme6_hori_gravity*2);
       nme6_id.nme6_hori_gravity=nme6_id.nme6_temp_hori_gravity;

       //nme6_id.nme6_hori_gravity-=12;

      end
     end

      if(nme6_id.nme6_flying==false)
        if(put_nme6_score==false)
        sound(s_para_pop,256,256);
         put_nme6_score=true;
         p1_score+=nme6_id.nme6_score2;
        end
        nme6_id.nme6_kill_enemy=true;

       end

    end


    if(bolt_id_code!=0)
     electrocute=true;
    end


    if(electrocute==true)
     signal(bolt_id_code,s_kill);
     signal(type balloon,s_kill);
     sound(s_electrocute,256,256);
     repeat
      electrocute_counter++;
      if(graph=<20 or graph>=23)graph=20;end
       graph++;


     frame;
     until(electrocute_counter>30)
     balloons=0;
    end
   end

   if(balloons==0)
    repeat
     fall_gravity++;
     y+=fall_gravity;
     if(fall_gravity>5)fall_gravity=10;end

     if(graph=<11 or graph>=18)graph=11;end
      graph++;

    frame;
    until(map_get_pixel(file,hardness_map,x/2,y/2)==59 or y>480);
    splash(x,y-55);
   break;end


  frame;
 end
end

process balloon(bounce_pos,x_bounce,z,b_flag);
private
 bounce_counter=0;
 y_bounce;
begin
 file=file1;

  loop
    x=father.x+x_bounce;
    y=father.y-23+y_bounce;
    bounce_counter++;

    if(father.flying==true);
     flags=b_flag;graph=201;
    end

    if(father.flying==false)
     flags=0;graph=balloon_graph;
    end

    if(bounce_counter>20 and bounce_pos==0)
     y_bounce=+1;bounce_counter=0;bounce_pos=1;
    end

    if(bounce_counter>20 and bounce_pos==1)
     y_bounce=-1;bounce_counter=0;bounce_pos=0;
    end

  frame;
 end
end


process enemy1(difficulty,x,y,file,nme_balloon_graph);
private
 nme1_graph_counter=0;
 nme1_wait_counter=0;
 nme1_wait_count=20;
 nme1_fly_counter=0;
 nme1_death_counter=-10;
 nme1_parasol_counter=0;
 nme1_parasol_turn_counter=0;
 nme1_temp_dist;
 nme1_temp_inc;
 nme1_gravity_counter;
 nme1_balloon_col;
 nme1_balloon_counter=0;
 nme1_direction;
 nme1_balloon_count=false;
 nme1_called_parasol=false;
 nme1_parasol_id;
 nme1_spinner_col;
begin
 //file=whatfile;
 graph=1;
 //nme1_balloon(0,100,1);

  loop
   if(difficulty==1)
    nme1_score1=500;nme1_score2=750;nme1_score3=1000;
    nme_balloon_graph=210;
   end
   if(difficulty==2)
    nme1_score1=750;nme1_score2=1000;nme1_score3=1500;
    nme_balloon_graph=211;
   end
   if(difficulty==3)
    nme1_score1=1000;nme1_score2=1500;nme1_score3=2000;
    nme_balloon_graph=212;
   end

   if(nme1_flying==false)
    nme1_wait_counter++;

    if(nme1_wait_counter>nme1_wait_count)
     nme1_graph_counter++;

     if(nme1_graph_counter>5)
      graph++;
      nme1_graph_counter=0;
     end

     if(graph>12)
      nme1_flying=true;nme1_balloon(nme_balloon_graph,0,100,1);
      ///////also temporary flying shit
      nme1_hori_gravity=4;
      ////////temporary flying shit
      if(difficulty==1)
       min_speed=-4;max_speed=4;
       nme_up1=25;nme_up2=50;
       nme_down1=75;nme_down2=100;
       nme1_score1=500;nme1_score2=750;nme1_score3=1000;
       file=nmefile1;
      end

      if(difficulty==2)
       min_speed=-5;max_speed=5;
       nme_up1=25;nme_up2=75;
       nme_down1=100;nme_down2=150;
       nme1_score1=750;nme1_score2=1000;nme1_score3=1500;
       file=nmefile2;
      end

      if(difficulty==3)
       min_speed=-6;max_speed=6;
       nme_up1=25;nme_up2=100;
       nme_down1=100;nme_down2=125;
       nme1_score1=1000;nme1_score2=1500;nme1_score3=2000;
       file=nmefile3;
      end

     end
    end
   end
    if(nme1_flying==true)
     if(nme1_stun_enemy==false)
     nme1_gravity_counter++;

      if(nme1_gravity_counter>1)
       nme1_gravity_counter=0;nme1_vert_gravity--;
      end

      x+=nme1_hori_gravity;


     //////////temporary flying shit
     ///////////////////////////////
     nme1_fly_counter++;
      if(nme1_fly_counter<rand(nme_up1,nme_up2))
       nme1_vert_gravity++;
         if(graph<=15 or graph=>18)graph=15;end
          graph++;
      else graph=20;end

      if(nme1_fly_counter>rand(nme_down1,nme_down2))
       nme1_hori_gravity=rand(min_speed,max_speed);
       nme1_fly_counter=0;
      end
     /////////temporary flying shit
     //////////////////////////////
      end

    end

    if(nme1_hori_gravity>0)
     flags=1;
    end

    if(nme1_hori_gravity<0)
     flags=0;
    end

    if(nme1_stun_enemy==true)
     if(nme1_called_parasol==false)
      nme1_parasol_counter++;
       if(nme1_parasol_counter>5)
        nme1_parasol_id=nme1_parasol(x,y);nme1_called_parasol=true;
        nme1_parasol_counter=0;
       end
     end

      graph=25;

      nme1_vert_gravity=-1;

      x+=nme1_hori_gravity;
      nme1_parasol_turn_counter++;

      if(nme1_hori_gravity=>4)
       nme1_direction=0;
      end

      if(nme1_hori_gravity=<-4)
       nme1_direction=1;
      end

      if(nme1_direction==0)
       if(nme1_parasol_turn_counter>2)
        nme1_hori_gravity--;
        nme1_parasol_turn_counter=0;
       end
      end

      if(nme1_direction==1)
       if(nme1_parasol_turn_counter>2)
        nme1_hori_gravity++;
        nme1_parasol_turn_counter=0;
       end
      end

    end

    if(nme1_kill_enemy==true)
     nme1_flying=false;nme1_stun_enemy=false;
     repeat
      if(graph=<30 or graph>=33)graph=30;end
       graph++;

       nme1_death_counter++;
       y+=nme1_death_counter;

       if(nme1_death_counter>8)nme1_death_counter=8;end


     frame;
     until(y>475)
     nme_splash(x,y-55);break;
    end

    ///////////////////


    if(nme1_vert_gravity!=0)
     nme1_temp_dist = nme1_vert_gravity;                    //save the distance to move

    nme1_temp_inc = nme1_vert_gravity / abs(nme1_vert_gravity);  //is it plus or minus 1!!!

    for( ; nme1_temp_dist != 0; nme1_temp_dist-= nme1_temp_inc)  //go through each point 1 to at most 6

       if(map_get_pixel(what_map_file,hardness_map,x/2,(y-nme1_temp_inc)/2)!=22)
                                                   //check next point for collision
         y-=nme1_temp_inc;         //move y value


        if(map_get_pixel(what_map_file,hardness_map,x/2,(y+nme1_temp_inc-40)/2)==54)
         nme1_vert_gravity-=4;
        end


       else
        if(nme1_stun_enemy==true)
         signal(nme1_parasol_id,s_kill);
         nme1_flying=false;nme1_stun_enemy=false;
         nme1_graph_counter=0;
         nme1_wait_counter=0;
         nme1_wait_count=50;
         nme1_fly_counter=0;
         nme1_balloon_counter=0;
         nme1_balloon_count=false;
         nme1_called_parasol=false;
         difficulty+=1;
         if(difficulty>3)difficulty=3;end
         graph=1;
        end
      end
     end
    end

    if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==73)
    nme1_hori_gravity-=6;
   end

   if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==41)
    nme1_hori_gravity+=6;
   end

   if(nme1_vert_gravity<-4)nme1_vert_gravity=-4;end
   if(nme1_vert_gravity>4)nme1_vert_gravity=4;end
   if(nme1_hori_gravity<min_speed)nme1_hori_gravity=min_speed;end
   if(nme1_hori_gravity>max_speed)nme1_hori_gravity=max_speed;end
   if(x<0)x=640;end
   if(x>640)x=0;end
   if(y<40)nme1_vert_gravity-=8;end
   if(y>475)nme_splash(x,y-55);
    signal(type nme1_balloon,s_kill);
   break;end

   nme1_spinner_col=collision(type spinner);
   if(nme1_spinner_col!=0)
    nme1_spinner_col.spin=true;
    nme1_vert_gravity+=rand(-4,4);
    nme1_hori_gravity+=rand(min_speed,max_speed);
   end

   nme1_balloon_col=collision(type balloon);


   if(man_id.active==true and nme1_stun_enemy==false)



    if(nme1_balloon_col!=0 and balloons==2)
     signal(balloon2_id,s_kill);sound(s_balloon_pop,256,256);
     nme1_vert_gravity+=10;man_id.vert_gravity-=10;
     nme1_balloon_count=true;nme1_balloon_counter=0;
    end

    if(nme1_balloon_count==true)
     nme1_balloon_counter++;
    end

    if(nme1_balloon_counter>2)
     balloons=1;nme1_balloon_counter=-100;
     nme1_balloon_count=false;
    end

    if(nme1_balloon_col!=0 and balloons==1)
     signal(balloon1_id,s_kill);sound(s_balloon_pop,256,256);
     balloons=0;
     nme1_vert_gravity+=12;//man_id.vert_gravity-=12;
    end
   end

  frame;
 end
end



process nme1_balloon(graph,nme1_bounce_pos,z,nme1_b_flag);
private
 nme1_bounce_counter=0;
 nme1_y_bounce;
begin
 file=file1;
  loop

    if(father.nme1_flying==true)
     x=father.x+5;
     y=father.y-21+nme1_y_bounce;
     nme1_bounce_counter++;

      flags=nme1_b_flag;//graph=210;

     if(nme1_bounce_counter>20 and nme1_bounce_pos==0)
      nme1_y_bounce=+1;nme1_bounce_counter=0;nme1_bounce_pos=1;
     end

     if(nme1_bounce_counter>20 and nme1_bounce_pos==1)
      nme1_y_bounce=-1;nme1_bounce_counter=0;nme1_bounce_pos=0;
     end
    end

  frame;
 end
end


process nme1_parasol(x,y);
private
begin
 file=file1;
 graph=250;
  loop
   x=father.x;
   y=father.y-21;
  frame;
 end
end


process enemy2(difficulty,x,y,file,nme_balloon_graph);
private
 nme2_graph_counter=0;
 nme2_wait_counter=0;
 nme2_wait_count=20;
 nme2_fly_counter=0;
 nme2_death_counter=-10;
 nme2_parasol_counter=0;
 nme2_parasol_turn_counter=0;
 nme2_temp_dist;
 nme2_temp_inc;
 nme2_gravity_counter;
 nme2_balloon_col;
 nme2_balloon_counter=0;
 nme2_direction;
 nme2_balloon_count=false;
 nme2_called_parasol=false;
 nme2_parasol_id;
 nme2_spinner_col;
begin
 //file=whatfile;
 graph=1;
 //nme2_balloon(0,100,1);

  loop
  if(difficulty==1)
    nme2_score1=500;nme2_score2=750;nme2_score3=1000;
    nme_balloon_graph=210;
   end
   if(difficulty==2)
    nme2_score1=750;nme2_score2=1000;nme2_score3=1500;
    nme_balloon_graph=211;
   end
   if(difficulty==3)
    nme2_score1=1000;nme2_score2=1500;nme2_score3=2000;
    nme_balloon_graph=212;
   end

   if(nme2_flying==false)
    nme2_wait_counter++;

    if(nme2_wait_counter>nme2_wait_count)
     nme2_graph_counter++;

     if(nme2_graph_counter>5)
      graph++;
      nme2_graph_counter=0;
     end

     if(graph>12)
      nme2_flying=true;nme2_balloon(nme_balloon_graph,0,100,1);
      nme2_hori_gravity=4;
      if(difficulty==1)
       min_speed=-4;max_speed=4;
       nme_up1=25;nme_up2=50;
       nme_down1=75;nme_down2=100;
       nme2_score1=500;nme2_score2=750;nme2_score3=1000;
       file=nmefile1;
      end

      if(difficulty==2)
       min_speed=-5;max_speed=5;
       nme_up1=25;nme_up2=75;
       nme_down1=100;nme_down2=150;
       nme2_score1=750;nme2_score2=1000;nme2_score3=1500;
       file=nmefile2;
      end

      if(difficulty==3)
       min_speed=-6;max_speed=6;
       nme_up1=25;nme_up2=100;
       nme_down1=100;nme_down2=125;
       nme2_score1=1000;nme2_score2=1500;nme2_score3=2000;
       file=nmefile3;
      end

     end
    end
   end
        /////////////Temporary
    if(nme2_flying==true)
     if(nme2_stun_enemy==false)
     nme2_gravity_counter++;

      if(nme2_gravity_counter>1)
       nme2_gravity_counter=0;nme2_vert_gravity--;
      end

      x+=nme2_hori_gravity;


     nme2_fly_counter++;
      if(nme2_fly_counter<rand(nme_up1,nme_up2))
       nme2_vert_gravity++;

         if(graph<=15 or graph=>18)graph=15;end
          graph++;
      else graph=20;end

      if(nme2_fly_counter>rand(nme_down1,nme_down2))
       nme2_fly_counter=0;
       nme2_hori_gravity=rand(min_speed,max_speed);
      end

     end

    end

    if(nme2_hori_gravity>0)
     flags=1;
    end

    if(nme2_hori_gravity<0)
     flags=0;
    end

    if(nme2_stun_enemy==true)
     if(nme2_called_parasol==false)
      nme2_parasol_counter++;
       if(nme2_parasol_counter>5)
        nme2_parasol_id=nme2_parasol(x,y);nme2_called_parasol=true;
        nme2_parasol_counter=0;
       end
     end

      graph=25;

      nme2_vert_gravity=-1;

      x+=nme2_hori_gravity;
      nme2_parasol_turn_counter++;

      if(nme2_hori_gravity=>4)
       nme2_direction=0;
      end

      if(nme2_hori_gravity=<-4)
       nme2_direction=1;
      end

      if(nme2_direction==0)
       if(nme2_parasol_turn_counter>2)
        nme2_hori_gravity--;
        nme2_parasol_turn_counter=0;
       end
      end

      if(nme2_direction==1)
       if(nme2_parasol_turn_counter>2)
        nme2_hori_gravity++;
        nme2_parasol_turn_counter=0;
       end
      end

    end

    if(nme2_kill_enemy==true)
     nme2_flying=false;nme2_stun_enemy=false;
     repeat
      if(graph=<30 or graph>=33)graph=30;end
       graph++;

       nme2_death_counter++;
       y+=nme2_death_counter;

       if(nme2_death_counter>8)nme2_death_counter=8;end


     frame;
     until(y>475)
     nme_splash(x,y-55);break;
    end

    ///////////////////


    if(nme2_vert_gravity!=0)
     nme2_temp_dist = nme2_vert_gravity;                    //save the distance to move

    nme2_temp_inc = nme2_vert_gravity / abs(nme2_vert_gravity);  //is it plus or minus 1!!!

    for( ; nme2_temp_dist != 0; nme2_temp_dist-= nme2_temp_inc)  //go through each point 1 to at most 6

       if(map_get_pixel(what_map_file,hardness_map,x/2,(y-nme2_temp_inc)/2)!=22)
                                                   //check next point for collision
         y-=nme2_temp_inc;         //move y value


        if(map_get_pixel(what_map_file,hardness_map,x/2,(y+nme2_temp_inc-40)/2)==54)
         nme2_vert_gravity-=4;
        end


       else
        if(nme2_stun_enemy==true)
         signal(nme2_parasol_id,s_kill);
         nme2_flying=false;nme2_stun_enemy=false;
         nme2_graph_counter=0;
         nme2_wait_counter=0;
         nme2_wait_count=50;
         nme2_fly_counter=0;
         nme2_balloon_counter=0;
         nme2_balloon_count=false;
         nme2_called_parasol=false;
         difficulty+=1;
         if(difficulty>3)difficulty=3;end
         graph=1;
        end
      end
     end
    end

    if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==73)
    nme2_hori_gravity-=6;
   end

   if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==41)
    nme2_hori_gravity+=6;
   end

   if(nme2_vert_gravity<-4)nme2_vert_gravity=-4;end
   if(nme2_vert_gravity>4)nme2_vert_gravity=4;end
   if(nme2_hori_gravity<min_speed)nme2_hori_gravity=min_speed;end
   if(nme2_hori_gravity>max_speed)nme2_hori_gravity=max_speed;end
   if(x<0)x=640;end
   if(x>640)x=0;end
   if(y<40)nme2_vert_gravity-=8;end
   if(y>475)nme_splash(x,y-55);
    signal(type nme2_balloon,s_kill);
   break;end
    nme2_spinner_col=collision(type spinner);
   if(nme2_spinner_col!=0)
    nme2_spinner_col.spin=true;
    nme2_vert_gravity+=rand(-4,4);
    nme2_hori_gravity+=rand(min_speed,max_speed);
   end

   nme2_balloon_col=collision(type balloon);

   if(man_id.active==true and nme2_stun_enemy==false)



    if(nme2_balloon_col!=0 and balloons==2)
     signal(balloon2_id,s_kill);sound(s_balloon_pop,256,256);
     nme2_vert_gravity+=10;man_id.vert_gravity-=10;
     nme2_balloon_count=true;nme2_balloon_counter=0;
    end

    if(nme2_balloon_count==true)
     nme2_balloon_counter++;
    end

    if(nme2_balloon_counter>2)
     balloons=1;nme2_balloon_counter=-100;
     nme2_balloon_count=false;
    end

    if(nme2_balloon_col!=0 and balloons==1)
     signal(balloon1_id,s_kill);sound(s_balloon_pop,256,256);
     balloons=0;
     nme2_vert_gravity+=12;//man_id.vert_gravity-=12;
    end
   end

  frame;
 end
end



process nme2_balloon(graph,nme2_bounce_pos,z,nme2_b_flag);
private
 nme2_bounce_counter=0;
 nme2_y_bounce;
begin
 file=file1;
  loop

    if(father.nme2_flying==true)
     x=father.x+5;
     y=father.y-21+nme2_y_bounce;
     nme2_bounce_counter++;

      flags=nme2_b_flag;//graph=210;

     if(nme2_bounce_counter>20 and nme2_bounce_pos==0)
      nme2_y_bounce=+1;nme2_bounce_counter=0;nme2_bounce_pos=1;
     end

     if(nme2_bounce_counter>20 and nme2_bounce_pos==1)
      nme2_y_bounce=-1;nme2_bounce_counter=0;nme2_bounce_pos=0;
     end
    end

  frame;
 end
end


process nme2_parasol(x,y);
private
begin
 file=file1;
 graph=250;
  loop
   x=father.x;
   y=father.y-21;
  frame;
 end
end


process enemy3(difficulty,x,y,file,nme_balloon_graph);
private
 nme3_graph_counter=0;
 nme3_wait_counter=0;
 nme3_wait_count=20;
 nme3_fly_counter=0;
 nme3_death_counter=-10;
 nme3_parasol_counter=0;
 nme3_parasol_turn_counter=0;
 nme3_temp_dist;
 nme3_temp_inc;
 nme3_gravity_counter;
 nme3_balloon_col;
 nme3_balloon_counter=0;
 nme3_direction;
 nme3_balloon_count=false;
 nme3_called_parasol=false;
 nme3_parasol_id;
 nme3_spinner_col;
begin
 //file=whatfile;
 graph=1;
 //nme3_balloon(0,100,1);

  loop
  if(difficulty==1)
    nme3_score1=500;nme3_score2=750;nme3_score3=1000;
    nme_balloon_graph=210;
   end
   if(difficulty==2)
    nme3_score1=750;nme3_score2=1000;nme3_score3=1500;
    nme_balloon_graph=211;
   end
   if(difficulty==3)
    nme3_score1=1000;nme3_score2=1500;nme3_score3=2000;
    nme_balloon_graph=212;
   end

   if(nme3_flying==false)
    nme3_wait_counter++;

    if(nme3_wait_counter>nme3_wait_count)
     nme3_graph_counter++;

     if(nme3_graph_counter>5)
      graph++;
      nme3_graph_counter=0;
     end

     if(graph>12)
      nme3_flying=true;nme3_balloon(nme_balloon_graph,0,100,1);
      nme3_hori_gravity=4;
      if(difficulty==1)
       min_speed=-4;max_speed=4;
       nme_up1=25;nme_up2=50;
       nme_down1=75;nme_down2=100;
       nme3_score1=500;nme3_score2=750;nme3_score3=1000;
       file=nmefile1;
      end

      if(difficulty==2)
       min_speed=-5;max_speed=5;
       nme_up1=25;nme_up2=75;
       nme_down1=100;nme_down2=150;
       nme3_score1=750;nme3_score2=1000;nme3_score3=1500;
       file=nmefile2;
      end

      if(difficulty==3)
       min_speed=-6;max_speed=6;
       nme_up1=25;nme_up2=100;
       nme_down1=100;nme_down2=125;
       nme3_score1=1000;nme3_score2=1500;nme3_score3=2000;
       file=nmefile3;
      end

     end
    end
   end
        /////////////Temporary
    if(nme3_flying==true)
     if(nme3_stun_enemy==false)
     nme3_gravity_counter++;

      if(nme3_gravity_counter>1)
       nme3_gravity_counter=0;nme3_vert_gravity--;
      end

      x+=nme3_hori_gravity;


     nme3_fly_counter++;
      if(nme3_fly_counter<rand(nme_up1,nme_up2))
       nme3_vert_gravity++;

         if(graph<=15 or graph=>18)graph=15;end
          graph++;
      else graph=20;end

      if(nme3_fly_counter>rand(nme_down1,nme_down2))
       nme3_fly_counter=0;
       nme3_hori_gravity=rand(min_speed,max_speed);
      end

     end

    end

    if(nme3_hori_gravity>0)
     flags=1;
    end

    if(nme3_hori_gravity<0)
     flags=0;
    end

    if(nme3_stun_enemy==true)
     if(nme3_called_parasol==false)
      nme3_parasol_counter++;
       if(nme3_parasol_counter>5)
        nme3_parasol_id=nme3_parasol(x,y);nme3_called_parasol=true;
        nme3_parasol_counter=0;
       end
     end

      graph=25;

      nme3_vert_gravity=-1;

      x+=nme3_hori_gravity;
      nme3_parasol_turn_counter++;

      if(nme3_hori_gravity=>4)
       nme3_direction=0;
      end

      if(nme3_hori_gravity=<-4)
       nme3_direction=1;
      end

      if(nme3_direction==0)
       if(nme3_parasol_turn_counter>2)
        nme3_hori_gravity--;
        nme3_parasol_turn_counter=0;
       end
      end

      if(nme3_direction==1)
       if(nme3_parasol_turn_counter>2)
        nme3_hori_gravity++;
        nme3_parasol_turn_counter=0;
       end
      end

    end

    if(nme3_kill_enemy==true)
     nme3_flying=false;nme3_stun_enemy=false;
     repeat
      if(graph=<30 or graph>=33)graph=30;end
       graph++;

       nme3_death_counter++;
       y+=nme3_death_counter;

       if(nme3_death_counter>8)nme3_death_counter=8;end


     frame;
     until(y>475)
     nme_splash(x,y-55);break;
    end

    ///////////////////


    if(nme3_vert_gravity!=0)
     nme3_temp_dist = nme3_vert_gravity;                    //save the distance to move

    nme3_temp_inc = nme3_vert_gravity / abs(nme3_vert_gravity);  //is it plus or minus 1!!!

    for( ; nme3_temp_dist != 0; nme3_temp_dist-= nme3_temp_inc)  //go through each point 1 to at most 6

       if(map_get_pixel(what_map_file,hardness_map,x/2,(y-nme3_temp_inc)/2)!=22)
                                                   //check next point for collision
         y-=nme3_temp_inc;         //move y value


        if(map_get_pixel(what_map_file,hardness_map,x/2,(y+nme3_temp_inc-40)/2)==54)
         nme3_vert_gravity-=4;
        end


       else
        if(nme3_stun_enemy==true)
         signal(nme3_parasol_id,s_kill);
         nme3_flying=false;nme3_stun_enemy=false;
         nme3_graph_counter=0;
         nme3_wait_counter=0;
         nme3_wait_count=50;
         nme3_fly_counter=0;
         nme3_balloon_counter=0;
         nme3_balloon_count=false;
         nme3_called_parasol=false;
         difficulty+=1;
         if(difficulty>3)difficulty=3;end
         graph=1;
        end
      end
     end
    end

    if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==73)
    nme3_hori_gravity-=6;
   end

   if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==41)
    nme3_hori_gravity+=6;
   end

   if(nme3_vert_gravity<-4)nme3_vert_gravity=-4;end
   if(nme3_vert_gravity>4)nme3_vert_gravity=4;end
   if(nme3_hori_gravity<min_speed)nme3_hori_gravity=min_speed;end
   if(nme3_hori_gravity>max_speed)nme3_hori_gravity=max_speed;end
   if(x<0)x=640;end
   if(x>640)x=0;end
   if(y<40)nme3_vert_gravity-=8;end
   if(y>475)nme_splash(x,y-55);
    signal(type nme3_balloon,s_kill);
   break;end
    nme3_spinner_col=collision(type spinner);
   if(nme3_spinner_col!=0)
    nme3_spinner_col.spin=true;
   nme3_vert_gravity+=rand(-4,4);
    nme3_hori_gravity+=rand(min_speed,max_speed);
   end

   nme3_balloon_col=collision(type balloon);

   if(man_id.active==true and nme3_stun_enemy==false)



    if(nme3_balloon_col!=0 and balloons==2)
     signal(balloon2_id,s_kill);sound(s_balloon_pop,256,256);
     nme3_vert_gravity+=10;man_id.vert_gravity-=10;
     nme3_balloon_count=true;nme3_balloon_counter=0;
    end

    if(nme3_balloon_count==true)
     nme3_balloon_counter++;
    end

    if(nme3_balloon_counter>2)
     balloons=1;nme3_balloon_counter=-100;
     nme3_balloon_count=false;
    end

    if(nme3_balloon_col!=0 and balloons==1)
     signal(balloon1_id,s_kill);sound(s_balloon_pop,256,256);
     balloons=0;
     nme3_vert_gravity+=12;//man_id.vert_gravity-=12;
    end
   end

  frame;
 end
end



process nme3_balloon(graph,nme3_bounce_pos,z,nme3_b_flag);
private
 nme3_bounce_counter=0;
 nme3_y_bounce;
begin
 file=file1;
  loop

    if(father.nme3_flying==true)
     x=father.x+5;
     y=father.y-21+nme3_y_bounce;
     nme3_bounce_counter++;

      flags=nme3_b_flag;//graph=210;

     if(nme3_bounce_counter>20 and nme3_bounce_pos==0)
      nme3_y_bounce=+1;nme3_bounce_counter=0;nme3_bounce_pos=1;
     end

     if(nme3_bounce_counter>20 and nme3_bounce_pos==1)
      nme3_y_bounce=-1;nme3_bounce_counter=0;nme3_bounce_pos=0;
     end
    end

  frame;
 end
end


process nme3_parasol(x,y);
private
begin
 file=file1;
 graph=250;
  loop
   x=father.x;
   y=father.y-21;
  frame;
 end
end

process enemy4(difficulty,x,y,file,nme_balloon_graph);
private
 nme4_graph_counter=0;
 nme4_wait_counter=0;
 nme4_wait_count=20;
 nme4_fly_counter=0;
 nme4_death_counter=-10;
 nme4_parasol_counter=0;
 nme4_parasol_turn_counter=0;
 nme4_temp_dist;
 nme4_temp_inc;
 nme4_gravity_counter;
 nme4_balloon_col;
 nme4_balloon_counter=0;
 nme4_direction;
 nme4_balloon_count=false;
 nme4_called_parasol=false;
 nme4_parasol_id;
 nme4_spinner_col;
begin
 //file=whatfile;
 graph=1;
 //nme4_balloon(0,100,1);

  loop
  if(difficulty==1)
    nme4_score1=500;nme4_score2=750;nme4_score3=1000;
    nme_balloon_graph=210;
   end
   if(difficulty==2)
    nme4_score1=750;nme4_score2=1000;nme4_score3=1500;
    nme_balloon_graph=211;
   end
   if(difficulty==3)
    nme4_score1=1000;nme4_score2=1500;nme4_score3=2000;
    nme_balloon_graph=212;
   end

   if(nme4_flying==false)
    nme4_wait_counter++;

    if(nme4_wait_counter>nme4_wait_count)
     nme4_graph_counter++;

     if(nme4_graph_counter>5)
      graph++;
      nme4_graph_counter=0;
     end

     if(graph>12)
      nme4_flying=true;nme4_balloon(nme_balloon_graph,0,100,1);
      ///////also temporary flying shit
      nme4_hori_gravity=4;
      ////////temporary flying shit
      if(difficulty==1)
       min_speed=-4;max_speed=4;
       nme_up1=25;nme_up2=50;
       nme_down1=75;nme_down2=100;
       nme4_score1=500;nme4_score2=750;nme4_score3=1000;
       file=nmefile1;
      end

      if(difficulty==2)
       min_speed=-5;max_speed=5;
       nme_up1=25;nme_up2=75;
       nme_down1=100;nme_down2=150;
       nme4_score1=750;nme4_score2=1000;nme4_score3=1500;
       file=nmefile2;
      end

      if(difficulty==3)
       min_speed=-6;max_speed=6;
       nme_up1=25;nme_up2=100;
       nme_down1=100;nme_down2=125;
       nme4_score1=1000;nme4_score2=1500;nme4_score3=2000;
       file=nmefile3;
      end

     end
    end
   end
    if(nme4_flying==true)
     if(nme4_stun_enemy==false)
     nme4_gravity_counter++;

      if(nme4_gravity_counter>1)
       nme4_gravity_counter=0;nme4_vert_gravity--;
      end

      x+=nme4_hori_gravity;


     //////////temporary flying shit
     ///////////////////////////////
     nme4_fly_counter++;
      if(nme4_fly_counter<rand(nme_up1,nme_up2))
       nme4_vert_gravity++;

         if(graph<=15 or graph=>18)graph=15;end
          graph++;
      else graph=20;end

      if(nme4_fly_counter>rand(nme_down1,nme_down2))
       nme4_hori_gravity=rand(min_speed,max_speed);
       nme4_fly_counter=0;
      end
     /////////temporary flying shit
     //////////////////////////////
      end

    end

    if(nme4_hori_gravity>0)
     flags=1;
    end

    if(nme4_hori_gravity<0)
     flags=0;
    end

    if(nme4_stun_enemy==true)
     if(nme4_called_parasol==false)
      nme4_parasol_counter++;
       if(nme4_parasol_counter>5)
        nme4_parasol_id=nme4_parasol(x,y);nme4_called_parasol=true;
        nme4_parasol_counter=0;
       end
     end

      graph=25;

      nme4_vert_gravity=-1;

      x+=nme4_hori_gravity;
      nme4_parasol_turn_counter++;

      if(nme4_hori_gravity=>4)
       nme4_direction=0;
      end

      if(nme4_hori_gravity=<-4)
       nme4_direction=1;
      end

      if(nme4_direction==0)
       if(nme4_parasol_turn_counter>2)
        nme4_hori_gravity--;
        nme4_parasol_turn_counter=0;
       end
      end

      if(nme4_direction==1)
       if(nme4_parasol_turn_counter>2)
        nme4_hori_gravity++;
        nme4_parasol_turn_counter=0;
       end
      end

    end

    if(nme4_kill_enemy==true)
     nme4_flying=false;nme4_stun_enemy=false;
     repeat
      if(graph=<30 or graph>=33)graph=30;end
       graph++;

       nme4_death_counter++;
       y+=nme4_death_counter;

       if(nme4_death_counter>8)nme4_death_counter=8;end


     frame;
     until(y>475)
     nme_splash(x,y-55);break;
    end

    ///////////////////


    if(nme4_vert_gravity!=0)
     nme4_temp_dist = nme4_vert_gravity;                    //save the distance to move

    nme4_temp_inc = nme4_vert_gravity / abs(nme4_vert_gravity);  //is it plus or minus 1!!!

    for( ; nme4_temp_dist != 0; nme4_temp_dist-= nme4_temp_inc)  //go through each point 1 to at most 6

       if(map_get_pixel(what_map_file,hardness_map,x/2,(y-nme4_temp_inc)/2)!=22)
                                                   //check next point for collision
         y-=nme4_temp_inc;         //move y value


        if(map_get_pixel(what_map_file,hardness_map,x/2,(y+nme4_temp_inc-40)/2)==54)
         nme4_vert_gravity-=4;
        end


       else
        if(nme4_stun_enemy==true)
         signal(nme4_parasol_id,s_kill);
         nme4_flying=false;nme4_stun_enemy=false;
         nme4_graph_counter=0;
         nme4_wait_counter=0;
         nme4_wait_count=50;
         nme4_fly_counter=0;
         nme4_balloon_counter=0;
         nme4_balloon_count=false;
         nme4_called_parasol=false;
         difficulty+=1;
         if(difficulty>3)difficulty=3;end
         graph=1;
        end
      end
     end
    end

    if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==73)
    nme4_hori_gravity-=6;
   end

   if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==41)
    nme4_hori_gravity+=6;
   end

   if(nme4_vert_gravity<-4)nme4_vert_gravity=-4;end
   if(nme4_vert_gravity>4)nme4_vert_gravity=4;end
   if(nme4_hori_gravity<min_speed)nme4_hori_gravity=min_speed;end
   if(nme4_hori_gravity>max_speed)nme4_hori_gravity=max_speed;end
   if(x<0)x=640;end
   if(x>640)x=0;end
   if(y<40)nme4_vert_gravity-=8;end
   if(y>475)nme_splash(x,y-55);
    signal(type nme4_balloon,s_kill);
   break;end
    nme4_spinner_col=collision(type spinner);
   if(nme4_spinner_col!=0)
    nme4_spinner_col.spin=true;

    nme4_vert_gravity+=rand(-4,4);
    nme4_hori_gravity+=rand(min_speed,max_speed);
   end

   nme4_balloon_col=collision(type balloon);


   if(man_id.active==true and nme4_stun_enemy==false)



    if(nme4_balloon_col!=0 and balloons==2)
     signal(balloon2_id,s_kill);sound(s_balloon_pop,256,256);
     nme4_vert_gravity+=10;man_id.vert_gravity-=10;
     nme4_balloon_count=true;nme4_balloon_counter=0;
    end

    if(nme4_balloon_count==true)
     nme4_balloon_counter++;
    end

    if(nme4_balloon_counter>2)
     balloons=1;nme4_balloon_counter=-100;
     nme4_balloon_count=false;
    end

    if(nme4_balloon_col!=0 and balloons==1)
     signal(balloon1_id,s_kill);sound(s_balloon_pop,256,256);
     balloons=0;
     nme4_vert_gravity+=12;//man_id.vert_gravity-=12;
    end
   end

  frame;
 end
end



process nme4_balloon(graph,nme4_bounce_pos,z,nme4_b_flag);
private
 nme4_bounce_counter=0;
 nme4_y_bounce;
begin
 file=file1;
  loop

    if(father.nme4_flying==true)
     x=father.x+5;
     y=father.y-21+nme4_y_bounce;
     nme4_bounce_counter++;

      flags=nme4_b_flag;//graph=210;

     if(nme4_bounce_counter>20 and nme4_bounce_pos==0)
      nme4_y_bounce=+1;nme4_bounce_counter=0;nme4_bounce_pos=1;
     end

     if(nme4_bounce_counter>20 and nme4_bounce_pos==1)
      nme4_y_bounce=-1;nme4_bounce_counter=0;nme4_bounce_pos=0;
     end
    end

  frame;
 end
end


process nme4_parasol(x,y);
private
begin
 file=file1;
 graph=250;
  loop
   x=father.x;
   y=father.y-21;
  frame;
 end
end

process enemy5(difficulty,x,y,file,nme_balloon_graph);
private
 nme5_graph_counter=0;
 nme5_wait_counter=0;
 nme5_wait_count=20;
 nme5_fly_counter=0;
 nme5_death_counter=-10;
 nme5_parasol_counter=0;
 nme5_parasol_turn_counter=0;
 nme5_temp_dist;
 nme5_temp_inc;
 nme5_gravity_counter;
 nme5_balloon_col;
 nme5_balloon_counter=0;
 nme5_direction;
 nme5_balloon_count=false;
 nme5_called_parasol=false;
 nme5_parasol_id;
 nme5_spinner_col;
begin
 //file=whatfile;
 graph=1;
 //nme5_balloon(0,100,1);

  loop
  if(difficulty==1)
    nme5_score1=500;nme5_score2=750;nme5_score3=1000;
    nme_balloon_graph=210;
   end
   if(difficulty==2)
    nme5_score1=750;nme5_score2=1000;nme5_score3=1500;
    nme_balloon_graph=211;
   end
   if(difficulty==3)
    nme5_score1=1000;nme5_score2=1500;nme5_score3=2000;
    nme_balloon_graph=212;
   end

   if(nme5_flying==false)
    nme5_wait_counter++;

    if(nme5_wait_counter>nme5_wait_count)
     nme5_graph_counter++;

     if(nme5_graph_counter>5)
      graph++;
      nme5_graph_counter=0;
     end

     if(graph>12)
      nme5_flying=true;nme5_balloon(nme_balloon_graph,0,100,1);
      ///////also temporary flying shit
      nme5_hori_gravity=4;
      ////////temporary flying shit
      if(difficulty==1)
       min_speed=-4;max_speed=4;
       nme_up1=25;nme_up2=50;
       nme_down1=75;nme_down2=100;
       nme5_score1=500;nme5_score2=750;nme5_score3=1000;
       file=nmefile1;
      end

      if(difficulty==2)
       min_speed=-5;max_speed=5;
       nme_up1=25;nme_up2=75;
       nme_down1=100;nme_down2=150;
       nme5_score1=750;nme5_score2=1000;nme5_score3=1500;
       file=nmefile2;
      end

      if(difficulty==3)
       min_speed=-6;max_speed=6;
       nme_up1=25;nme_up2=100;
       nme_down1=100;nme_down2=125;
       nme5_score1=1000;nme5_score2=1500;nme5_score3=2000;
       file=nmefile3;
      end

     end
    end
   end
    if(nme5_flying==true)
     if(nme5_stun_enemy==false)
     nme5_gravity_counter++;

      if(nme5_gravity_counter>1)
       nme5_gravity_counter=0;nme5_vert_gravity--;
      end

      x+=nme5_hori_gravity;


     //////////temporary flying shit
     ///////////////////////////////
     nme5_fly_counter++;
      if(nme5_fly_counter<rand(nme_up1,nme_up2))
       nme5_vert_gravity++;

         if(graph<=15 or graph=>18)graph=15;end
          graph++;
      else graph=20;end

      if(nme5_fly_counter>rand(nme_down1,nme_down2))
       nme5_hori_gravity=rand(min_speed,max_speed);
       nme5_fly_counter=0;
      end
     /////////temporary flying shit
     //////////////////////////////
      end

    end

    if(nme5_hori_gravity>0)
     flags=1;
    end

    if(nme5_hori_gravity<0)
     flags=0;
    end

    if(nme5_stun_enemy==true)
     if(nme5_called_parasol==false)
      nme5_parasol_counter++;
       if(nme5_parasol_counter>5)
        nme5_parasol_id=nme5_parasol(x,y);nme5_called_parasol=true;
        nme5_parasol_counter=0;
       end
     end

      graph=25;

      nme5_vert_gravity=-1;

      x+=nme5_hori_gravity;
      nme5_parasol_turn_counter++;

      if(nme5_hori_gravity=>4)
       nme5_direction=0;
      end

      if(nme5_hori_gravity=<-4)
       nme5_direction=1;
      end

      if(nme5_direction==0)
       if(nme5_parasol_turn_counter>2)
        nme5_hori_gravity--;
        nme5_parasol_turn_counter=0;
       end
      end

      if(nme5_direction==1)
       if(nme5_parasol_turn_counter>2)
        nme5_hori_gravity++;
        nme5_parasol_turn_counter=0;
       end
      end

    end

    if(nme5_kill_enemy==true)
     nme5_flying=false;nme5_stun_enemy=false;
     repeat
      if(graph=<30 or graph>=33)graph=30;end
       graph++;

       nme5_death_counter++;
       y+=nme5_death_counter;

       if(nme5_death_counter>8)nme5_death_counter=8;end


     frame;
     until(y>475)
     nme_splash(x,y-55);break;
    end

    ///////////////////


    if(nme5_vert_gravity!=0)
     nme5_temp_dist = nme5_vert_gravity;                    //save the distance to move

    nme5_temp_inc = nme5_vert_gravity / abs(nme5_vert_gravity);  //is it plus or minus 1!!!

    for( ; nme5_temp_dist != 0; nme5_temp_dist-= nme5_temp_inc)  //go through each point 1 to at most 6

       if(map_get_pixel(what_map_file,hardness_map,x/2,(y-nme5_temp_inc)/2)!=22)
                                                   //check next point for collision
         y-=nme5_temp_inc;         //move y value


        if(map_get_pixel(what_map_file,hardness_map,x/2,(y+nme5_temp_inc-40)/2)==54)
         nme5_vert_gravity-=4;
        end


       else
        if(nme5_stun_enemy==true)
         signal(nme5_parasol_id,s_kill);
         nme5_flying=false;nme5_stun_enemy=false;
         nme5_graph_counter=0;
         nme5_wait_counter=0;
         nme5_wait_count=50;
         nme5_fly_counter=0;
         nme5_balloon_counter=0;
         nme5_balloon_count=false;
         nme5_called_parasol=false;
         difficulty+=1;
         if(difficulty>3)difficulty=3;end
         graph=1;
        end
      end
     end
    end

    if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==73)
    nme5_hori_gravity-=6;
   end

   if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==41)
    nme5_hori_gravity+=6;
   end

   if(nme5_vert_gravity<-4)nme5_vert_gravity=-4;end
   if(nme5_vert_gravity>4)nme5_vert_gravity=4;end
   if(nme5_hori_gravity<min_speed)nme5_hori_gravity=min_speed;end
   if(nme5_hori_gravity>max_speed)nme5_hori_gravity=max_speed;end
   if(x<0)x=640;end
   if(x>640)x=0;end
   if(y<40)nme5_vert_gravity-=8;end
   if(y>475)nme_splash(x,y-55);
    signal(type nme5_balloon,s_kill);
   break;end
    nme5_spinner_col=collision(type spinner);
   if(nme5_spinner_col!=0)
    nme5_spinner_col.spin=true;
   nme5_vert_gravity+=rand(-4,4);
    nme5_hori_gravity+=rand(min_speed,max_speed);
   end

   nme5_balloon_col=collision(type balloon);


   if(man_id.active==true and nme5_stun_enemy==false)



    if(nme5_balloon_col!=0 and balloons==2)
     signal(balloon2_id,s_kill);sound(s_balloon_pop,256,256);
     nme5_vert_gravity+=10;man_id.vert_gravity-=10;
     nme5_balloon_count=true;nme5_balloon_counter=0;
    end

    if(nme5_balloon_count==true)
     nme5_balloon_counter++;
    end

    if(nme5_balloon_counter>2)
     balloons=1;nme5_balloon_counter=-100;
     nme5_balloon_count=false;
    end

    if(nme5_balloon_col!=0 and balloons==1)
     signal(balloon1_id,s_kill);sound(s_balloon_pop,256,256);
     balloons=0;
     nme5_vert_gravity+=12;//man_id.vert_gravity-=12;
    end
   end

  frame;
 end
end



process nme5_balloon(graph,nme5_bounce_pos,z,nme5_b_flag);
private
 nme5_bounce_counter=0;
 nme5_y_bounce;
begin
 file=file1;
  loop

    if(father.nme5_flying==true)
     x=father.x+5;
     y=father.y-21+nme5_y_bounce;
     nme5_bounce_counter++;

      flags=nme5_b_flag;//graph=210;

     if(nme5_bounce_counter>20 and nme5_bounce_pos==0)
      nme5_y_bounce=+1;nme5_bounce_counter=0;nme5_bounce_pos=1;
     end

     if(nme5_bounce_counter>20 and nme5_bounce_pos==1)
      nme5_y_bounce=-1;nme5_bounce_counter=0;nme5_bounce_pos=0;
     end
    end

  frame;
 end
end


process nme5_parasol(x,y);
private
begin
 file=file1;
 graph=250;
  loop
   x=father.x;
   y=father.y-21;
  frame;
 end
end


process enemy6(difficulty,x,y,file,nme_balloon_graph);
private
 nme6_graph_counter=0;
 nme6_wait_counter=0;
 nme6_wait_count=20;
 nme6_fly_counter=0;
 nme6_death_counter=-10;
 nme6_parasol_counter=0;
 nme6_parasol_turn_counter=0;
 nme6_temp_dist;
 nme6_temp_inc;
 nme6_gravity_counter;
 nme6_balloon_col;
 nme6_balloon_counter=0;
 nme6_direction;
 nme6_balloon_count=false;
 nme6_called_parasol=false;
 nme6_parasol_id;
 nme6_spinner_col;
begin
 //file=whatfile;
 graph=1;
 //nme6_balloon(0,100,1);

  loop
  if(difficulty==1)
    nme6_score1=500;nme6_score2=750;nme6_score3=1000;
    nme_balloon_graph=210;
   end
   if(difficulty==2)
    nme6_score1=750;nme6_score2=1000;nme6_score3=1500;
    nme_balloon_graph=211;
   end
   if(difficulty==3)
    nme6_score1=1000;nme6_score2=1500;nme6_score3=2000;
    nme_balloon_graph=212;
   end

   if(nme6_flying==false)
    nme6_wait_counter++;

    if(nme6_wait_counter>nme6_wait_count)
     nme6_graph_counter++;

     if(nme6_graph_counter>5)
      graph++;
      nme6_graph_counter=0;
     end

     if(graph>12)
      nme6_flying=true;nme6_balloon(nme_balloon_graph,0,100,1);
      ///////also temporary flying shit
      nme6_hori_gravity=4;
      ////////temporary flying shit
      if(difficulty==1)
       min_speed=-4;max_speed=4;
       nme_up1=25;nme_up2=50;
       nme_down1=75;nme_down2=100;
       nme6_score1=500;nme6_score2=750;nme6_score3=1000;
       file=nmefile1;
      end

      if(difficulty==2)
       min_speed=-5;max_speed=5;
       nme_up1=25;nme_up2=75;
       nme_down1=100;nme_down2=150;
       nme6_score1=750;nme6_score2=1000;nme6_score3=1500;
       file=nmefile2;
      end

      if(difficulty==3)
       min_speed=-6;max_speed=6;
       nme_up1=25;nme_up2=100;
       nme_down1=100;nme_down2=125;
       nme6_score1=1000;nme6_score2=1500;nme6_score3=2000;
       file=nmefile3;
      end

     end
    end
   end
    if(nme6_flying==true)
     if(nme6_stun_enemy==false)
     nme6_gravity_counter++;

      if(nme6_gravity_counter>1)
       nme6_gravity_counter=0;nme6_vert_gravity--;
      end

      x+=nme6_hori_gravity;


     //////////temporary flying shit
     ///////////////////////////////
     nme6_fly_counter++;
      if(nme6_fly_counter<rand(nme_up1,nme_up2))
       nme6_vert_gravity++;

         if(graph<=15 or graph=>18)graph=15;end
          graph++;
      else graph=20;end

      if(nme6_fly_counter>rand(nme_down1,nme_down2))
       nme6_hori_gravity=rand(min_speed,max_speed);
       nme6_fly_counter=0;
      end
     /////////temporary flying shit
     //////////////////////////////
      end

    end

    if(nme6_hori_gravity>0)
     flags=1;
    end

    if(nme6_hori_gravity<0)
     flags=0;
    end

    if(nme6_stun_enemy==true)
     if(nme6_called_parasol==false)
      nme6_parasol_counter++;
       if(nme6_parasol_counter>5)
        nme6_parasol_id=nme6_parasol(x,y);nme6_called_parasol=true;
        nme6_parasol_counter=0;
       end
     end

      graph=25;

      nme6_vert_gravity=-1;

      x+=nme6_hori_gravity;
      nme6_parasol_turn_counter++;

      if(nme6_hori_gravity=>4)
       nme6_direction=0;
      end

      if(nme6_hori_gravity=<-4)
       nme6_direction=1;
      end

      if(nme6_direction==0)
       if(nme6_parasol_turn_counter>2)
        nme6_hori_gravity--;
        nme6_parasol_turn_counter=0;
       end
      end

      if(nme6_direction==1)
       if(nme6_parasol_turn_counter>2)
        nme6_hori_gravity++;
        nme6_parasol_turn_counter=0;
       end
      end

    end

    if(nme6_kill_enemy==true)
     nme6_flying=false;nme6_stun_enemy=false;
     repeat
      if(graph=<30 or graph>=33)graph=30;end
       graph++;

       nme6_death_counter++;
       y+=nme6_death_counter;

       if(nme6_death_counter>8)nme6_death_counter=8;end


     frame;
     until(y>475)
     nme_splash(x,y-55);break;
    end

    ///////////////////


    if(nme6_vert_gravity!=0)
     nme6_temp_dist = nme6_vert_gravity;                    //save the distance to move

    nme6_temp_inc = nme6_vert_gravity / abs(nme6_vert_gravity);  //is it plus or minus 1!!!

    for( ; nme6_temp_dist != 0; nme6_temp_dist-= nme6_temp_inc)  //go through each point 1 to at most 6

       if(map_get_pixel(what_map_file,hardness_map,x/2,(y-nme6_temp_inc)/2)!=22)
                                                   //check next point for collision
         y-=nme6_temp_inc;         //move y value


        if(map_get_pixel(what_map_file,hardness_map,x/2,(y+nme6_temp_inc-40)/2)==54)
         nme6_vert_gravity-=4;
        end


       else
        if(nme6_stun_enemy==true)
         signal(nme6_parasol_id,s_kill);
         nme6_flying=false;nme6_stun_enemy=false;
         nme6_graph_counter=0;
         nme6_wait_counter=0;
         nme6_wait_count=50;
         nme6_fly_counter=0;
         nme6_balloon_counter=0;
         nme6_balloon_count=false;
         nme6_called_parasol=false;
         difficulty+=1;
         if(difficulty>3)difficulty=3;end
         graph=1;
        end
      end
     end
    end

    if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==73)
    nme6_hori_gravity-=6;
   end

   if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==41)
    nme6_hori_gravity+=6;
   end

   if(nme6_vert_gravity<-4)nme6_vert_gravity=-4;end
   if(nme6_vert_gravity>4)nme6_vert_gravity=4;end
   if(nme6_hori_gravity<min_speed)nme6_hori_gravity=min_speed;end
   if(nme6_hori_gravity>max_speed)nme6_hori_gravity=max_speed;end
   if(x<0)x=640;end
   if(x>640)x=0;end
   if(y<40)nme6_vert_gravity-=8;end
   if(y>475)nme_splash(x,y-55);
    signal(type nme6_balloon,s_kill);
   break;end
    nme6_spinner_col=collision(type spinner);
    if(nme6_spinner_col!=0)
    nme6_spinner_col.spin=true;

    nme6_vert_gravity+=rand(-4,4);
    nme6_hori_gravity+=rand(min_speed,max_speed);
   end

   nme6_balloon_col=collision(type balloon);


   if(man_id.active==true and nme6_stun_enemy==false)



    if(nme6_balloon_col!=0 and balloons==2)
     signal(balloon2_id,s_kill);sound(s_balloon_pop,256,256);
     nme6_vert_gravity+=10;man_id.vert_gravity-=10;
     nme6_balloon_count=true;nme6_balloon_counter=0;
    end

    if(nme6_balloon_count==true)
     nme6_balloon_counter++;
    end

    if(nme6_balloon_counter>2)
     balloons=1;nme6_balloon_counter=-100;
     nme6_balloon_count=false;
    end

    if(nme6_balloon_col!=0 and balloons==1)
     signal(balloon1_id,s_kill);sound(s_balloon_pop,256,256);
     balloons=0;
     nme6_vert_gravity+=12;//man_id.vert_gravity-=12;
    end
   end

  frame;
 end
end



process nme6_balloon(graph,nme6_bounce_pos,z,nme6_b_flag);
private
 nme6_bounce_counter=0;
 nme6_y_bounce;
begin
 file=file1;
  loop

    if(father.nme6_flying==true)
     x=father.x+5;
     y=father.y-21+nme6_y_bounce;
     nme6_bounce_counter++;

      flags=nme6_b_flag;//graph=210;

     if(nme6_bounce_counter>20 and nme6_bounce_pos==0)
      nme6_y_bounce=+1;nme6_bounce_counter=0;nme6_bounce_pos=1;
     end

     if(nme6_bounce_counter>20 and nme6_bounce_pos==1)
      nme6_y_bounce=-1;nme6_bounce_counter=0;nme6_bounce_pos=0;
     end
    end

  frame;
 end
end


process nme6_parasol(x,y);
private
begin
 file=file1;
 graph=250;
  loop
   x=father.x;
   y=father.y-21;
  frame;
 end
end



process pipes(x,y,graph);
private
begin
 file=file1;
 z=150;
  loop
  frame;
 end
end

process bonus_balloon(x,y);
private
begin
 file=file1;
 graph=710;
 z=200;
  loop

   graph++;
   if(graph>717)graph=710;end

   y-=4;

   if(y<0);break;end

    if(collision(type man) or collision(type balloon))
       p1_score+=300;sound(s_balloon_pop,256,256);
       from graph=720 to 721; frame;end
      break;end

  frame;
 end
end


process stars(x,y,star_set);
private
 star_counter;

begin
 if(star_set==1)
  graph=rand(300,304);
 end

 if(star_set==2)
  graph=rand(305,309);
 end

 if(star_set==3)
  graph=rand(310,313);
 end

 if(star_set==4)
  graph=rand(314,319);
 end

 z=1000;
  loop
    star_counter++;

    if(star_counter>rand(50,250));
     if(star_set==1)
      graph=rand(300,304);
     end

     if(star_set==2)
      graph=rand(305,309);
     end

     if(star_set==3)
      graph=rand(310,313);
     end

     if(star_set==4)
      graph=rand(314,319);
     end

     star_counter=0;
     x+=(rand(-2,2));
     y+=(rand(-2,2));
    end
  frame;
 end
end

process spinner(x,y,graph,angle);
private
 spinner_counter=0;
begin
 file=file1;
 z=1000;

  loop
   if(spin==true)
    spinner_counter++;
    angle+=45000;
   end

   if(spinner_counter>50)
    spin=false;
    spinner_counter=0;
   end
  frame;
 end
end


process sea(x,y);
private
begin
 file=file1;
 graph=500;
 z=-1000;
  loop
  frame;
 end
end

process cloud(x,y);
private
 cloud_counter=0;
 balloon_rand;
 strike=false;
 direction;
begin
 file=file1;
 graph=525;
 z=900;
 balloon_rand=rand(300,1500);
  loop

   cloud_counter++;

   if(cloud_counter>balloon_rand and strike==false)
    strike=true;cloud_counter=0;
   end

   if(strike==true)
     graph++;

     if(graph>527)
      graph=525;
     end

    if(cloud_counter>40)
     direction=rand(1,4);

      if(direction==1) lightning(x+30,y+50,0,2,4); end
      if(direction==2) lightning(x-30,y+50,1,-2,4); end
      if(direction==3) lightning(x+30,y-50,2,2,-4); end
      if(direction==4) lightning(x-30,y-50,3,-2,-4); end

     strike=false;cloud_counter=0;
    end
   end

  frame;
 end
end

process lightning(x,y,flags,x_direction,y_direction);
private
 lightning_graph_counter=0;
 lightning_counter=0;
begin
 graph=550;
 z=950;
 sound(s_lightning,256,256);
  loop
   lightning_graph_counter++;
   lightning_counter++;

   if(lightning_graph_counter>2)
    graph++;
   end

    if(graph>553)
     graph=552;
    end

   if(lightning_counter>20)
    bolt_id=bolt(x,y,x_direction,y_direction);
   break;end

  frame;
 end
end

process bolt(x,y,x_direction,y_direction);
private
begin
 graph=575;

  loop

   graph++;
   if(graph>576)graph=575;end

   x+=x_direction;
   y+=y_direction;

    if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==22)
     y_direction=-4;
    end

    if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==54)
     y_direction=+4;
    end

    if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==73)
     x_direction=-2;
    end

    if(map_get_pixel(what_map_file,hardness_map,x/2,y/2)==41)
     x_direction=+2;
    end

    if(y<0)y_direction=+4;end
    if(x<0)x_direction=+2;end
    if(x>640)x_direction=-2;end
    if(y>480)break;end

  frame;
 end
end


process bubble(x,y);
private
 bubble_counter;
 bubble_hori_gravity;
 bubble_direction=1;
 bubble_turn_counter=0;
begin
 file=file1;
 graph=275;

  loop
   bubble_counter++;

    if(bubble_counter>30)

     y-=2;
     x+=bubble_hori_gravity;
     bubble_turn_counter++;

      if(bubble_hori_gravity=>4)
       bubble_direction=0;
      end

      if(bubble_hori_gravity=<-4)
       bubble_direction=1;
      end

      if(bubble_direction==0)
       if(bubble_turn_counter>2)
        bubble_hori_gravity--;
        bubble_turn_counter=0;
       end
      end

      if(bubble_direction==1)
       if(bubble_turn_counter>2)
        bubble_hori_gravity++;
        bubble_turn_counter=0;
       end
      end

      if(y<0)break;end

      if(collision(type man) or collision(type balloon))
       p1_score+=500;sound(s_bubble_pop,256,256);
       from graph=276 to 277; frame;end
      break;end

     end
  frame;
 end
end

process splash(x,y);
private
 splash_counter;
begin
 file=file1;
 z=-2000;
 graph=400;
 sound(s_splash,256,256);
  loop
   graph++;

   if(graph>407)
    graph=999;
   end

   splash_counter++;

   if(splash_counter>25)
    p1_lives-=1;
     if(p1_lives>-1)balloons=2;
      sound(s_player_die,256,256);man_id=man(95,412);
     break;end

     if(p1_lives==-1)
      fade_off();
      clear_screen();
      delete_text(all_text);
      //stop_sound(all_sound);
      let_me_alone();
      game_over();;
      fade_on();
     break;end
   end
  frame;
 end
end

process nme_splash(x,y);
private
begin
 file=file1;
 z=-2000;
 graph=400;
 sound(s_splash,256,256);
  loop
   graph++;

   if(graph>407)
   number_of_enemies-=1;bubble(x,480);break;end
  frame;
 end
end


process lives(x,y);
private
begin
 file=file1;
 z=1500;
  loop

   if(p1_lives==2)
    graph=650;
   end

   if(p1_lives==1)
    graph=651;
   end

   if(p1_lives==0)
    graph=999;
   end
  frame;
 end
end