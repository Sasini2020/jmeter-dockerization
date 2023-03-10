#!/bin/bash

jmx_array=("Test1.jmx" "Test2.jmx")
env_filename='.env'

for jmx_file_name in ${jmx_array[@]}; do
  echo $jmx_file_name

  #set jmx_file_name to JMX value inside .env file
  printf "\nJMX=$jmx_file_name" >> $env_filename

  #run the docker-compose up for a particular JMX file
  source .env && JMX=$jmx_file_name sudo docker-compose -p jmeter up --scale jmeter-slave=${nbInjector} -d

  #remove the appended lines inside environment file
  sed -i '$d' .env
done
