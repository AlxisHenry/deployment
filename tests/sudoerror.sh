#!/bin/bash

source ../.env;
ssh $REMOTE_SERVER_USER@$REMOTE_SERVER_IP "sudo -S chown -R $REMOTE_SERVER_USER:$REMOTE_SERVER_USER $REMOTE_PATH_TO_ROOT/$remote_app_name";
