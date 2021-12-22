;;;======================================================
;;;   Netflix Sci-Fi TV-shows Expert System
;;;
;;;   This expert system to help you choose
;;;   sci-fi series to watch on Netflix.
;;;
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))
   
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

  =>
  
  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUERY RULES *
;;;***************

(defrule determineBranch
   (logical (start))
   =>
   (assert (UI-state (display StartQuestion)
                     (relation-asserted Branch)
                     (response SciFi)
                     (valid-answers SciFi Horror Slipstream Fantasy))))

;;;***************
;;;*   SCI-FI    *
;;;***************
   
(defrule rSciFiAnthologies
   (logical (Branch SciFi))
   =>
   (assert (UI-state (display LikeAnthologies)
                     (relation-asserted ScifiAnthologies)
                     (response Yep)
                     (valid-answers Yep Nope))))

(defrule rSpaceHome
   (logical (ScifiAnthologies Nope))
   =>
   (assert (UI-state (display dSpaceHome)
                     (relation-asserted SpaceHome)
                     (response Stars)
                     (valid-answers Stars Home))))      
                     
(defrule rSciFiFriendliesInvader
   (logical (SpaceHome Home))
   =>
   (assert (UI-state (display dSciFiFriendliesInvader)
                     (relation-asserted SciFiFriendliesInvader)
                     (response Friends)
                     (valid-answers Friends Invaders))))   
                     
(defrule rSciFiLiveAnimated
   (logical (SciFiFriendliesInvader Invaders))
   =>
   (assert (UI-state (display dSciFiLiveAnimated)
                     (relation-asserted SciFiLiveAnimated)
                     (response Live)
                     (valid-answers Live Toons)))) 
                     
(defrule rSciFiComedy
   (logical (SpaceHome Stars))
   =>
   (assert (UI-state (display dSciFiComedy)
                     (relation-asserted SciFiComedy)
                     (response Nope)
                     (valid-answers Nope Yep))))    
                     
(defrule rSciFiBritishAmerican
   (logical (SciFiComedy Yep))
   =>
   (assert (UI-state (display dSciFiBritishAmerican)
                     (relation-asserted SciFiBritishAmerican)
                     (response UK)
                     (valid-answers UK USA))))                         

(defrule rSciFiTrekkie
   (logical (SciFiComedy Nope))
   =>
   (assert (UI-state (display dSciFiTrekkie)
                     (relation-asserted SciFiTrekkie)
                     (response Nope)
                     (valid-answers Nope Yep YepBut))))

(defrule rSciFiWillWheaton
   (logical (SciFiTrekkie Yep))
   =>
   (assert (UI-state (display dSciFiWillWheaton)
                     (relation-asserted SciFiWillWheaton)
                     (response Woot)
                     (valid-answers Woot NOOOO))))
                     
(defrule rSciFiStudy
   (logical (SciFiWillWheaton NOOOO))
   =>
   (assert (UI-state (display dSciFiStudy)
                     (relation-asserted SciFiStudy)
                     (response PS)
                     (valid-answers PS WL Sociology History))))
                     
(defrule rSciFiWestern
   (logical (SciFiTrekkie Nope))
   =>
   (assert (UI-state (display dSciFiWestern)
                     (relation-asserted SciFiWestern)
                     (response Nope)
                     (valid-answers Nope Yep))))
                     
(defrule rSciFiTSGateway
   (logical (SciFiWestern Nope))
   =>
   (assert (UI-state (display dSciFiTSGateway)
                     (relation-asserted SciFiTSGateway)
                     (response Nope)
                     (valid-answers Nope Yep))))

(defrule rSciFiBritishAmericanTS
   (logical (SciFiTSGateway Yep))
   =>
   (assert (UI-state (display dSciFiBritishAmerican)
                     (relation-asserted SciFiBritishAmericanTS)
                     (response UK)
                     (valid-answers UK USA))))

(defrule rSciFiClassicModern
   (logical (SciFiTSGateway Nope))
   =>
   (assert (UI-state (display dSciFiClassicModern)
                     (relation-asserted SciFiClassicModern)
                     (response Classic)
                     (valid-answers Classic Modern))))
                     
;;;***************
;;;*   HORROR    *
;;;***************

(defrule rVampiresZombies
   (logical (Branch Horror))
   =>
   (assert (UI-state (display dVampiresZombies)
                     (relation-asserted vampiresZombies)
                     (response Vampires)
                     (valid-answers Vampires Zombies Neither))))

(defrule rHorrorAnthologies
   (logical (vampiresZombies Neither))
   =>
   (assert (UI-state (display LikeAnthologies)
                     (relation-asserted horrorAnthologies)
                     (response Nope)
                     (valid-answers Nope Yep))))
                     
(defrule rPsychologicalGory
   (logical (horrorAnthologies Yep))
   =>
   (assert (UI-state (display dPsychologicalGory)
                     (relation-asserted psychologicalGory)
                     (response Psycho)
                     (valid-answers Psycho Gory))))

(defrule rHorrorAge
   (logical (vampiresZombies Vampires))
   =>
   (assert (UI-state (display dHorrorAge)
                     (relation-asserted HorrorAge)
                     (response <16)
                     (valid-answers <16 >16))))
                     
(defrule rHorrorSFWNSFW
   (logical (HorrorAge >16))
   =>
   (assert (UI-state (display dHorrorSFWNSFW)
                     (relation-asserted HorrorSFWNSFW)
                     (response SFW)
                     (valid-answers SFW NSFW))))
                     
(defrule rHorrorBritishAmerican
   (logical (HorrorSFWNSFW NSFW))
   =>
   (assert (UI-state (display dHorrorBritishAmerican)
                     (relation-asserted HorrorBritishAmerican)
                     (response UK)
                     (valid-answers UK USA))))

(defrule rHorrorSeenBuffy
   (logical (HorrorSFWNSFW SFW))
   =>
   (assert (UI-state (display dHorrorSeenBuffy)
                     (relation-asserted HorrorSeenBuffy)
                     (response Yep)
                     (valid-answers Yep Nope))))

;;;***************
;;;* SLIPSTREAM  *
;;;***************

(defrule rSlipstreamActionOrDrama
   (logical (Branch Slipstream))
   =>
   (assert (UI-state (display dActionOrDrama)
                     (relation-asserted SlipstreamActionOrDrama)
                     (response Action)
                     (valid-answers Action Drama))))
                     
(defrule rSlipstreamBiopunkOrSteampunk
   (logical (SlipstreamActionOrDrama Action))
   =>
   (assert (UI-state (display dBiopunkOrSteampunk)
                     (relation-asserted SlipstreamBiopunkOrSteampunk)
                     (response Biopunk)
                     (valid-answers Biopunk Steampunk))))
                     
(defrule rWhedonOrCameron
   (logical (SlipstreamBiopunkOrSteampunk Biopunk))
   =>
   (assert (UI-state (display dWhedonOrCameron)
                     (relation-asserted SlipstreamWhedonOrCameron)
                     (response Whedon)
                     (valid-answers Whedon Cameron))))
                     
(defrule rX-files
   (logical (SlipstreamActionOrDrama Drama))
   =>
   (assert (UI-state (display dX-files)
                     (relation-asserted SlipstreamX-files)
                     (response Yep)
                     (valid-answers Yep Nope HatedIt))))
                     
(defrule rOkWithLetDown
   (logical (SlipstreamX-files HatedIt))
   =>
   (assert (UI-state (display dOkWithLetDown)
                     (relation-asserted SlipstreamOkWithLetDown)
                     (response Yep)
                     (valid-answers Yep Nope))))

(defrule rScottBakula
   (logical (SlipstreamOkWithLetDown Nope))
   =>
   (assert (UI-state (display dScottBakula)
                     (relation-asserted SlipstreamScottBakula)
                     (response Who)
                     (valid-answers Who Fan))))

;;;***************
;;;*   FANTASY   *
;;;***************

(defrule rFantasyUrbanOrPeriod
   (logical (Branch Fantasy))
   =>
   (assert (UI-state (display dUrbanOrPeriod)
                     (relation-asserted FantasyUrbanOrPeriod)
                     (response Urban)
                     (valid-answers Urban Period))))
                     
(defrule rLikeSuperheroes
   (logical (FantasyUrbanOrPeriod Urban))
   =>
   (assert (UI-state (display dLikeSuperheroes)
                     (relation-asserted FantasyLikeSuperheroes)
                     (response Yep)
                     (valid-answers Yep Nope))))
                     
(defrule rSuperheroesAnimatedOrLive
   (logical (FantasyLikeSuperheroes Yep))
   =>
   (assert (UI-state (display dAnimatedOrLive)
                     (relation-asserted FantasySupeheroesAnimatedOrLive)
                     (response Live)
                     (valid-answers Live Toons))))
                     
(defrule rHowAboutMythology
   (logical (FantasyLikeSuperheroes Nope))
   =>
   (assert (UI-state (display dHowAboutMythology)
                     (relation-asserted FantasyHowAboutMythology)
                     (response Yep)
                     (valid-answers Yep Nope))))

(defrule rMythsOrLegends
   (logical (FantasyUrbanOrPeriod Period))
   =>
   (assert (UI-state (display dMythsOrLegends)
                     (relation-asserted FantasyMythsOrLegends)
                     (response Myths)
                     (valid-answers Myths Legends))))
                     
(defrule rBuffDudesOrHotGirls
   (logical (FantasyMythsOrLegends Myths))
   =>
   (assert (UI-state (display dBuffDudesOrHotGirls)
                     (relation-asserted FantasyBuffDudesOrHotGirls)
                     (response Ladies)
                     (valid-answers Ladies Dudes))))
                     
(defrule rLegendsAnimatedOrLive
   (logical (FantasyMythsOrLegends Legends))
   =>
   (assert (UI-state (display dAnimatedOrLive)
                     (relation-asserted FantasyLegendsAnimatedOrLive)
                     (response Live)
                     (valid-answers Live Toons))))
                     
(defrule rLikeNudity
   (logical (FantasyLegendsAnimatedOrLive Live))
   =>
   (assert (UI-state (display dLikeNudity)
                     (relation-asserted FantasyLikeNudity)
                     (response Yep)
                     (valid-answers Yep Nope))))
                     
(defrule rHaveGameboy
   (logical (FantasyLegendsAnimatedOrLive Toons))
   =>
   (assert (UI-state (display dHaveGameboy)
                     (relation-asserted FantasyHaveGameboy)
                     (response Nope)
                     (valid-answers Nope Yep))))

;;;**********************
;;;* SERIES SUGGESTIONS *
;;;**********************

;;;***************
;;;*   SCI-FI    *
;;;***************

(defrule ScifiAnthologyConclusion
   (logical (ScifiAnthologies Yep))
   =>
   (assert (UI-state (display Outer)
                     (state final))))

(defrule SciFiLiveAnimatedConclusion
   (logical (SciFiLiveAnimated Live))
   =>
   (assert (UI-state (display V)
                     (state final))))

(defrule SciFiLiveAnimatedConclusion2
   (logical (SciFiLiveAnimated Toons))
   =>
   (assert (UI-state (display InvaderZim)
                     (state final))))

(defrule SciFiFriendliesInvaderConclusion
   (logical (SciFiFriendliesInvader Friends))
   =>
   (assert (UI-state (display AlienNation)
                     (state final))))

(defrule SciFiBritishAmericanConclusion
   (logical (SciFiBritishAmerican UK))
   =>
   (assert (UI-state (display RedDwarfI)
                     (state final))))
                     
(defrule SciFiBritishAmericanConclusion2
   (logical (SciFiBritishAmerican USA))
   =>
   (assert (UI-state (display Futurama)
                     (state final))))                   

(defrule SciFiTrekkieConclusion
   (logical (SciFiTrekkie YepBut))
   =>
   (assert (UI-state (display Earth)
                     (state final))))

(defrule SciFiWillWheatonConclusion
   (logical (SciFiWillWheaton Woot))
   =>
   (assert (UI-state (display TheNextGeneration)
                     (state final))))

(defrule SciFiStudyConclusion
   (logical (SciFiStudy PS))
   =>
   (assert (UI-state (display StarTrekDeep)
                     (state final))))

(defrule SciFiStudyConclusion2
   (logical (SciFiStudy WL))
   =>
   (assert (UI-state (display StarTrekVoyager)
                     (state final))))
                     
(defrule SciFiStudyConclusion3
   (logical (SciFiStudy Sociology))
   =>
   (assert (UI-state (display StarTrekOriginal)
                     (state final))))
                     
(defrule SciFiStudyConclusion4
   (logical (SciFiStudy History))
   =>
   (assert (UI-state (display StarTrekEnterprise)
                     (state final))))
                     
(defrule SciFiWesternConclusion
   (logical (SciFiWestern Yep))
   =>
   (assert (UI-state (display Firefly)
                     (state final))))        

(defrule SciFiClassicModernConclusion
   (logical (SciFiClassicModern Modern))
   =>
   (assert (UI-state (display BattlerstarSO)
                     (state final))))     

(defrule SciFiClassicModernConclusion2
   (logical (SciFiClassicModern Classic))
   =>
   (assert (UI-state (display Battlerstar)
                     (state final)))) 

(defrule SciFiBritishAmericanTSConclusion
   (logical (SciFiBritishAmericanTS UK))
   =>
   (assert (UI-state (display DocWho)
                     (state final))))
                     
(defrule SciFiBritishAmericanTSConclusion2
   (logical (SciFiBritishAmericanTS USA))
   =>
   (assert (UI-state (display Stargate)
                     (state final))))
                     
;;;***************
;;;*   HORROR    *
;;;***************

(defrule horrorZombiesConclusion
   (logical (vampiresZombies Zombies))
   =>
   (assert (UI-state (display TheWalkingDead)
                     (state final)))) 

(defrule horrorAnthologiesConclusion
   (logical (horrorAnthologies Nope))
   =>
   (assert (UI-state (display Charmed)
                     (state final)))) 
                     
(defrule psychologicalGoryConclusion
   (logical (psychologicalGory Psycho))
   =>
   (assert (UI-state (display TheTwilightZone)
                     (state final))))                  
                     
(defrule goryPsychologicalConclusion
   (logical (psychologicalGory Gory))
   =>
   (assert (UI-state (display TalesFromTheCrypt)
                     (state final)))) 
                     
(defrule HorrorAgeConclusion
   (logical (HorrorAge <16))
   =>
   (assert (UI-state (display DampireDiaries)
                     (state final))))                      

(defrule HorrorBritishAmericanConclusion
   (logical (HorrorBritishAmerican UK))
   =>
   (assert (UI-state (display BeingHuman)
                     (state final))))       

(defrule HorrorBritishAmericanConclusion2
   (logical (HorrorBritishAmerican USA))
   =>
   (assert (UI-state (display TrueBlood)
                     (state final))))  
                      
(defrule HorrorSeenBuffyConclusion
   (logical (HorrorSeenBuffy Nope))
   =>
   (assert (UI-state (display Buffy)
                     (state final))))   
                     
(defrule HorrorSeenBuffyConclusion2
   (logical (HorrorSeenBuffy Yep))
   =>
   (assert (UI-state (display Angel)
                     (state final))))  

;;;***************
;;;* SLIPSTREAM  *
;;;***************

(defrule SlipstreamSteampunkConclusion
   (logical (SlipstreamBiopunkOrSteampunk Steampunk))
   =>
   (assert (UI-state (display Sanctuary)
                     (state final))))
                     
(defrule SlipstreamCameronConclusion
   (logical (SlipstreamWhedonOrCameron Cameron))
   =>
   (assert (UI-state (display DarkAngel)
                     (state final))))
                     
(defrule SlipstreamWhedonConclusion
   (logical (SlipstreamWhedonOrCameron Whedon))
   =>
   (assert (UI-state (display Dollhouse)
                     (state final))))
                     
(defrule SlipstreamX-files-YepConclusion
   (logical (SlipstreamX-files Yep))
   =>
   (assert (UI-state (display Fringe)
                     (state final))))
                     
(defrule SlipstreamX-files-NopeConclusion
   (logical (SlipstreamX-files Nope))
   =>
   (assert (UI-state (display X-files)
                     (state final))))
                     
(defrule SlipstreamOkWithBeingLetDown-YepConclusion
   (logical (SlipstreamOkWithLetDown Yep))
   =>
   (assert (UI-state (display Lost)
                     (state final))))
                     
(defrule SlipstreamScottBakula-WhoConclusion
   (logical (SlipstreamScottBakula Who))
   =>
   (assert (UI-state (display Warehouse13)
                     (state final))))
                     
(defrule SlipstreamScottBakula-FanConclusion
   (logical (SlipstreamScottBakula Fan))
   =>
   (assert (UI-state (display QuantumLeap)
                     (state final))))

;;;***************
;;;*   FANTASY   *
;;;***************

(defrule FantasySuperheroesLiveConclusion
   (logical (FantasySupeheroesAnimatedOrLive Live))
   =>
   (assert (UI-state (display Smallville)
                     (state final))))
                     
(defrule FantasySuperheroesToonsConclusion
   (logical (FantasySupeheroesAnimatedOrLive Toons))
   =>
   (assert (UI-state (display TheTick)
                     (state final))))
                     
(defrule FantasyMythology-YepConclusion
   (logical (FantasyHowAboutMythology Yep))
   =>
   (assert (UI-state (display Highlander)
                     (state final))))
                     
(defrule FantasyMythology-NopeConclusion
   (logical (FantasyHowAboutMythology Nope))
   =>
   (assert (UI-state (display DresdenFiles)
                     (state final))))
                     
(defrule FantasyDudesOrLadies-LadiesConclusion
   (logical (FantasyBuffDudesOrHotGirls Ladies))
   =>
   (assert (UI-state (display Xena)
                     (state final))))
                     
(defrule FantasyDudesOrLadies-DudesConclusion
   (logical (FantasyBuffDudesOrHotGirls Dudes))
   =>
   (assert (UI-state (display Hercules)
                     (state final))))
                     
(defrule FantasyLikeNudity-YepConclusion
   (logical (FantasyLikeNudity Yep))
   =>
   (assert (UI-state (display Spartacus)
                     (state final))))
                     
(defrule FantasyLikeNudity-NopeConclusion
   (logical (FantasyLikeNudity Nope))
   =>
   (assert (UI-state (display LegendOfTheSeeker)
                     (state final))))
                     
(defrule FantasyHaveGameboy-NopeConclusion
   (logical (FantasyHaveGameboy Nope))
   =>
   (assert (UI-state (display Avatar)
                     (state final))))
                     
(defrule FantasyHaveGameboy-YepConclusion
   (logical (FantasyHaveGameboy Yep))
   =>
   (assert (UI-state (display Pokemon)
                     (state final))))

;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   
