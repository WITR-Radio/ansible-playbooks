#!/bin/bash

# Template out a new YML file with someone's credentials, to remove them from
# our systems.
# Usage: ./apply_template_unauthorized.sh $RIT_USERNAME $USER_ID $PATH_TO_SSH_KEY_FILE

USERNAME=$1
USER_ID=$2
KEY_FILE_PATH=$3
KEY_FILE_CONTENTS=$(cat "${KEY_FILE_PATH}")

cat > "./${USERNAME}.yaml" << EOF
---

- name: ensure group ${USERNAME} does not exist
  group:
      name: ${USERNAME}
      gid: ${USER_ID}
      state: absent
  tags:
    - auth

- name: ensure user ${USERNAME} does not exist
  user:
      name: ${USERNAME}
      uid: ${USER_ID}
      group: ${USERNAME}
      groups: 
        - wheel
      state: absent
  tags:
    - auth

- name: ensure ${USERNAME}'s SSH key does not exist
  authorized_key:
      key: |
        ${KEY_FILE_CONTENTS}
      user: ${USERNAME}
      state: absent
      manage_dir: yes
      exclusive: yes
  tags:
    - auth
EOF
