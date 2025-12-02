#!/bin/bash

FILE="employee.txt"


check_duplicate() {
    if grep -q "^$1 " "$FILE"; then
        return 0    # duplicate exists
    else
        return 1    # no duplicate
    fi
}


check_exists() {
    if grep -q "^$1 " "$FILE"; then
        return 0
    else
        return 1
    fi
}

while true
do
    echo ""
    echo "====== Employee Management System ======"
    echo "1. Create Employee Table"
    echo "2. Insert New Entry"
    echo "3. Delete Entry"
    echo "4. Search Entry"
    echo "5. Display Table"
    echo "6. Exit"
    echo "Enter your choice: "
    read choice

    case $choice in
        1)
            echo "Enter number of employee entries to create: "
            read n

            echo "Building Employee Table..."
            echo "EmployeeID Name Role" > $FILE

            for (( i=1; i<=n; i++ ))
            do
                echo "Enter details for Employee $i"

             
                while true
                do
                    echo -n "Employee ID: "
                    read id
                    if check_duplicate "$id"; then
                        echo "Error: Employee ID already exists! Enter another."
                    else
                        break
                    fi
                done

                echo -n "Employee Name: "
                read name
                echo -n "Employee Role: "
                read role
                echo "$id $name $role" >> $FILE
                echo "Entry added."
            done
            echo "Employee table created successfully!"
            ;;

        2)

            while true
            do
                echo -n "Enter Employee ID: "
                read id
                if check_duplicate "$id"; then
                    echo "Error: Employee ID already exists! Try again."
                else
                    break
                fi
            done

            echo -n "Enter Employee Name: "
            read name
            echo -n "Enter Employee Role: "
            read role
            echo "$id $name $role" >> $FILE
            echo "Record inserted successfully."
            ;;

        3)
            echo -n "Enter Employee ID to delete: "
            read id

            if check_exists "$id"; then
                grep -v "^$id " $FILE > tmp.txt && mv tmp.txt $FILE
                echo "Record deleted successfully."
            else
                echo "Error: Employee ID not found."
            fi
            ;;

        4)
            echo -n "Enter Employee ID to search: "
            read id

            if check_exists "$id"; then
                grep "^$id " $FILE
            else
                echo "Error: Employee ID not found."
            fi
            ;;

        5)
            echo "------ Employee Records ------"
            cat $FILE
            echo "------------------------------"
            ;;

        6)
            echo "Exiting... Thank You!"
            exit
            ;;

        *)
            echo "Invalid Choice! Try Again."
            ;;
    esac
done
