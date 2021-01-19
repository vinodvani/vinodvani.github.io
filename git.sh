#!/bin/bash

git add .

read -p "What is happening: " COMMIT

git commit -m "$COMMIT"

git push


