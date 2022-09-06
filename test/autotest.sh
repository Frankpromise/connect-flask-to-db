#!/bin/bash
# testing endpoints

# tests
test_api_1=$(curl --write-out "%{http_code}\n" http://127.0.0.1:8080 --silent | tail -n 1) # or use curl --write-out "%{http_code}\n" http://127.0.0.1:5000 | tail -n 1
test_api_2=$(curl --write-out "%{http_code}\n" http://127.0.0.1:5000 --silent | tail -n 1)
test_api_3=$(curl --write-out "%{http_code}\n" http://127.0.0.1:5000/health --silent | tail -c 4)
test_api_4=$(curl --write-out "%{http_code}\n" http://127.0.0.1:5000/get-providers --silent | tail -n 1)
test_api_5=$(curl --write-out "%{http_code}\n" http://127.0.0.1:5000/add-provider --silent | tail -n 1)
test_api_6=$(curl --write-out "%{http_code}\n" http://127.0.0.1:5000/truck --silent | tail -n 1)

list_tests=("$test_api_1" "$test_api_2" "$test_api_3" "$test_api_4" "$test_api_5" "$test_api_6")
i=0

echo ${list_tests[@]} # check variables and if it works comment this line out

for api in ${list_tests[@]}; do
  if [[ $api -eq 200 ]]; then
    ((i++))
    echo "api $i was tested and returned OK"
  elif [[ $api -eq 000 ]]; then
    ((i++))
    echo "api $i status code: $api, check if network is running"
  else
    ((i++))
    echo "api $i did not return OK"
  fi
done
