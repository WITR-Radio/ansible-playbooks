#!/bin/bash

# Template out a new YML file with someone's credentials.
# Usage: ./apply_template.sh $RIT_USERNAME $USER_ID $PATH_TO_SSH_KEY_FILE

USERNAME=$1
USER_ID=$2
KEY_FILE_PATH=$3
KEY_FILE_CONTENTS=$(cat "${KEY_FILE_PATH}")

cat > "./${USERNAME}.yaml" << EOF
---

- name: ensure group ${USERNAME} exists
  group:
      name: ${USERNAME}
      gid: ${USER_ID}
      state: present
  tags:
    - auth

- name: ensure user ${USERNAME} exists
  user:
      name: ${USERNAME}
      uid: ${USER_ID}
      group: ${USERNAME}
      groups: 
        - wheel
      state: present
  tags:
    - auth

- name: ensure ${USERNAME}'s SSH key exists
  authorized_key:
      key: |
        ${KEY_FILE_CONTENTS}
      user: ${USERNAME}
      state: present
      manage_dir: yes
      exclusive: yes
  tags:
    - auth

EOF
