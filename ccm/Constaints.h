//
//  Constaints.h
//  ccm
//
//  Created by Brenton Durkee on 7/28/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#ifndef ccm_Constaints_h
#define ccm_Constaints_h

#define URL_DOMAIN @"http://ccm.brentondurkee.com"

#define URL_GET_EVENTS (URL_DOMAIN @"/api/events")
#define URL_GET_MESSAGES (URL_DOMAIN @"/api/messages/mine")
#define URL_GET_TALKS (URL_DOMAIN @"/api/talks")
#define URL_GET_GROUPS (URL_DOMAIN @"/api/groups")
#define URL_GET_LOCATIONS (URL_DOMAIN @"/api/locations")
#define URL_GET_TOPICS (URL_DOMAIN @"/api/topics")
#define URL_GET_SIGNUPS (URL_DOMAIN @"/api/signups")
#define URL_GET_MY_INFO (URL_DOMAIN @"/api/users/me")

#define URL_POST_EVENTS (URL_DOMAIN @"/api/events")
#define URL_POST_MESSAGES (URL_DOMAIN @"/api/messages")
#define URL_POST_TALKS (URL_DOMAIN @"/api/talks")
#define URL_POST_SIGNUPS (URL_DOMAIN @"/api/signups")

#define URL_PUT_SIGNUPS (URL_DOMAIN @"/api/signups/addme")

#define KEY_EVENT_DATA @"events"
#define KEY_MESSAGES_DATA @"msgs"
#define KEY_TALKS_DATA @"talks"
#define KEY_GROUPS_DATA @"groups"
#define KEY_LOCATIONS_DATA @"locations"
#define KEY_TOPICS_DATA @"topics"
#define KEY_SIGNUPS_DATA @"signups"

#define ENTITY_EVENT @"Events"
#define ENTITY_MESSAGES @"Messages"
#define ENTITY_TALKS @"Talks"
#define ENTITY_GROUPS @"Groups"
#define ENTITY_LOCATIONS @"Locations"
#define ENTITY_TOPICS @"Topics"
#define ENTITY_SIGNUPS @"Signups"

#define KEY_HAS_TOKEN @"has_token"
#define KEY_EMAIL @"email"
#define KEY_GROUPS @"groups"
#define KEY_INITIAL_SYNC @"initital_sync"

#define GROUP_FOR_RECEIVE @"ministers"

#define KEYCHAIN_ID_TOKEN @"token"
#define KEYCHAIN_KEY_TOKEN @"auth_token"


#endif
