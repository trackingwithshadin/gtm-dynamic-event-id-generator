___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Dynamic Event ID Generator | Tracking with Shadin",
  "description": "Generate unique and consistent Event IDs for deduplication between Pixel and Conversions API (CAPI). Ensures 100% data matching for Meta, GA4, and TikTok.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "idSuffix",
    "displayName": "Suffix Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "random",
        "displayValue": "Random Number"
      },
      {
        "value": "timestamp",
        "displayValue": "Timestamp (ms)"
      },
      {
        "value": "both",
        "displayValue": "Both (Recommended)"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "both"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const generateRandom = require('generateRandom');
const getTimestamp = require('getTimestamp');
const makeString = require('makeString');
const copyFromWindow = require('copyFromWindow');
const setInWindow = require('setInWindow');
const callInWindow = require('callInWindow');

const suffixType = data.idSuffix;

// Function to generate a high-entropy unique ID
const createNewId = () => {
  const randomNum = generateRandom(10000000, 99999999);
  const timestamp = getTimestamp();
  if (suffixType === 'random') return makeString(randomNum);
  if (suffixType === 'timestamp') return makeString(timestamp);
  return makeString(timestamp) + '.' + makeString(randomNum);
};

/**
 * Mismatch Protection Logic:
 * We use the last event's timestamp as a fallback unique identifier 
 * to ensure consistency if the system prevents direct dataLayer access.
 */
let eventMarker = getTimestamp();

// Try to get a more stable marker if possible
const dl = copyFromWindow('dataLayer');
if (dl && dl.length > 0) {
  const lastEvent = dl[dl.length - 1];
  eventMarker = lastEvent['gtm.uniqueEventId'] || eventMarker;
}

const cacheKey = '_shadin_eid_cache';
const eventCache = copyFromWindow(cacheKey) || {};

// Check if we already have an ID for this specific event marker
if (eventCache.marker === eventMarker) {
  return eventCache.id;
}

// Generate new ID and save it
const finalId = createNewId();
setInWindow(cacheKey, {
  marker: eventMarker,
  id: finalId
}, true);

return finalId;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  },
                  {
                    "type": 1,
                    "string": "key"
                  }
                ],
                "mapValue": [
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 1,
                    "string": "dataLayer"
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  },
                  {
                    "type": 1,
                    "string": "key"
                  }
                ],
                "mapValue": [
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 1,
                    "string": "_shadin_eid_cache"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 2/25/2026, 11:40:00 AM


___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.
