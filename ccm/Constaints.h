//
//  Constaints.h
//  ccm
//
//  Created by Brenton Durkee on 7/28/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#ifndef ccm_Constaints_h
#define ccm_Constaints_h


#ifdef DEBUG
#define URL_BASE @"http://ccmtest.brentondurkee.com"
#else
#define URL_BASE @"http://ccm.brentondurkee.com"
#endif

#define URL_DOMAIN URL_BASE @"/api/"

#define URL_GET_EVENTS (URL_DOMAIN @"events")
#define URL_GET_TALKS (URL_DOMAIN @"talks")
#define URL_GET_GROUPS (URL_DOMAIN @"groups")
#define URL_GET_LOCATIONS (URL_DOMAIN @"locations")
#define URL_GET_TOPICS (URL_DOMAIN @"topics")
#define URL_GET_SIGNUPS (URL_DOMAIN @"signups")
#define URL_GET_CONVOS (URL_DOMAIN @"conversations/android")
#define URL_GET_BROADCASTS (URL_DOMAIN @"broadcasts/mine")
#define URL_GET_MY_INFO (URL_DOMAIN @"users/me")

#define URL_POST_EVENTS (URL_DOMAIN @"events")
#define URL_POST_TALKS (URL_DOMAIN @"talks")
#define URL_POST_SIGNUPS (URL_DOMAIN @"signups")
#define URL_POST_CONVO (URL_DOMAIN @"conversations")
#define URL_POST_BC (URL_DOMAIN @"broadcasts/send")
#define URL_POST_SYNCAST (URL_DOMAIN @"broadcasts/sync")
#define URL_POST_GCM (URL_DOMAIN @"users/gcm")

#define URL_PUT_SIGNUPS (URL_DOMAIN @"signups/addme")
#define URL_PUT_MSG_CONVO (URL_DOMAIN @"conversations/send")
#define URL_PUT_KILL_CONVO (URL_DOMAIN @"conversations/kill")
#define URL_PUT_KILL_BC (URL_DOMAIN @"broadcasts/kill")

#define URL_POST_SIGNIN (URL_BASE @"/auth/local")
#define URL_POST_SIGNUP (URL_DOMAIN @"users")

#define KEY_EVENT_DATA @"events"
#define KEY_TALKS_DATA @"talks"
#define KEY_GROUPS_DATA @"groups"
#define KEY_LOCATIONS_DATA @"locations"
#define KEY_TOPICS_DATA @"topics"
#define KEY_SIGNUPS_DATA @"signups"
#define KEY_BROADCAST_DATA @"broadcasts"
#define KEY_CONVO_DATA @"convo"

#define ENTITY_EVENT @"Events"
#define ENTITY_TALKS @"Talks"
#define ENTITY_GROUPS @"Groups"
#define ENTITY_LOCATIONS @"Locations"
#define ENTITY_TOPICS @"Topics"
#define ENTITY_SIGNUPS @"Signups"
#define ENTITY_CONVO @"Conversation"
#define ENTITY_BROADCAST @"Broadcast"

#define KEY_HAS_TOKEN @"has_token"
#define KEY_EMAIL @"email"
#define KEY_GROUPS @"groups"
#define KEY_INITIAL_SYNC @"initital_sync"
#define KEY_GCM_SUBMITTED @"gcm_submitted"
#define KEY_GCM_TOKEN @"gcm_token"

#define GROUP_FOR_RECEIVE @"ministers"

#define KEYCHAIN_ID_TOKEN @"token"
#define KEYCHAIN_KEY_TOKEN @"auth_token"

#define NOTIFY_EVENTS_UPDATE @"EventsUpdatedNotification"
#define NOTIFY_SIGNUPS_UPDATE @"SignupsUpdatedNotification"
#define NOTIFY_TALKS_UPDATE @"TalksUpdatedNotification"


#endif
