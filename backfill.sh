#!/bin/bash

# Make sure you're inside your Git repository
git status

# Number of commits per month (random between 15-20)
MIN_COMMITS=15
MAX_COMMITS=20

# Counter for numbered updates
update_counter=1

# Go back 12 months
for month_offset in $(seq 0 11); do
    # Get year and month for this offset (macOS compatible)
    year=$(date -v-${month_offset}m +%Y)
    month=$(date -v-${month_offset}m +%m)
    
    # Number of days in this month (macOS way)
    days_in_month=$(date -v${year}y -v${month}m -v1d -v+1m -v-1d +%d)
    
    # Random number of commits this month
    num_commits=$((RANDOM % (MAX_COMMITS - MIN_COMMITS + 1) + MIN_COMMITS))
    
    echo "========================================"
    echo "Creating $num_commits commits for $year-$month"
    echo "========================================"
    
    for ((i=1; i<=num_commits; i++)); do
        # Random day in the month
        day=$((RANDOM % days_in_month + 1))
        day_padded=$(printf "%02d" $day)
        
        # Random time between 9 AM and 8 PM
        hour=$((RANDOM % 12 + 9))
        minute=$((RANDOM % 60))
        minute_padded=$(printf "%02d" $minute)
        
        full_timestamp="$year-$month-$day_padded ${hour}:${minute_padded}:00"
        
        # Simple random messages
        simple_messages=(
            "update $update_counter"
            "update"
            "test"
            "fix"
            "changes"
            "wip"
            "random"
            "stuff"
            "temp"
            "cleanup"
            "patch"
            "minor update"
            "small fix"
            "test $RANDOM"
            "update again"
        )
        
        message=${simple_messages[$RANDOM % ${#simple_messages[@]}]}
        
        # Sometimes force a numbered update
        if (( RANDOM % 3 == 0 )); then
            message="update $update_counter"
            ((update_counter++))
        fi
        
        echo "  → $full_timestamp | $message"
        
        # Create some content change
        echo "$message - $full_timestamp" >> .git-history-log
        echo "Random data: $RANDOM-$RANDOM-$RANDOM" >> .git-history-log
        
        # Create the commit with backdated dates
        GIT_AUTHOR_DATE="$full_timestamp" \
        GIT_COMMITTER_DATE="$full_timestamp" \
        git add .git-history-log && \
        GIT_AUTHOR_DATE="$full_timestamp" \
        GIT_COMMITTER_DATE="$full_timestamp" \
        git commit -m "$message" --quiet
    done
done

echo ""
echo "Done! Created random simple commits spanning the past 12 months."
