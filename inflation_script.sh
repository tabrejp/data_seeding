#/bin/bash

####################################################################################
# This script will creae the multiple files for data inflation
#
#
# Format of the output File:
# DATE_TIME | BAN | IP
# File Format:
# 2016-08-02 11:20:00|855555655|104.8.88.110|kfyvwnmpctcfyr.com|||1|rcdtxv6gstl06
#
#
####################################################################################

export APP_DIR=`pwd`
export FILE_DIR="$APP_DIR/files"
export LOG_DIR="$APP_DIR/logs"
export DELIMITER="|"
export NO_FILES=10
export NO_RECS=10000
#export BAN=100000001

export BAN_FL="$APP_DIR/BAN.txt"
echo "100000001" > $BAN_FL

export LOG_NM=${LOG_DIR}/inflat_`date "+%Y-%m-%d_%H%M%S"`.log


export BAN=`head -1 $BAN_FL`
export IP_1=10
export IP_2=100
export IP_3=100
export IP_4=1
export FILE_FRMT
#export FILE_DT=`date "+%Y%m%d%H%M%S"`
export TIER1=$APP_DIR/tier_1_category.txt
export TIER2=$APP_DIR/tier_2_category.txt
export DNS_REQ=$APP_DIR/no_dns_request.txt
export GNS_PROBE=$APP_DIR/gstool_probe.txt

#create 10 files each with 100 records.
#change the BAN number accordingly with


echo $APP_DIR
echo $DELIMITER
echo $NO_FILES
echo $NO_RECS
echo $BAN
echo $IP_1
echo $IP_2
echo $IP_3
echo $IP_4
echo $BAN_FL
echo $BAN


################################################################################
# Create the data files now
echo Process started @ `date "+%Y-%m-%d %H:%M:%S"` >> $LOG_NM
echo Creating data files >> $LOG_NM
echo Creating data files
echo >> $LOG_NM

for (( i=1; i <= ${NO_FILES}; i++))
do
        #echo $i
        #echo "I am in the Loop"
        export FILE_DT=`date "+%Y%m%d%H%M%S"`
        #echo ${FILE_DT}
        export FILE_NM=${FILE_DT}_dns_1_1_10min.csv
        `touch ${FILE_DIR}/$FILE_NM`

        if [[ -f ${FILE_DIR}/$FILE_NM ]] then
                echo File created successfully >> $LOG_NM
                echo ${FILE_DIR}/$FILE_NM >> $LOG_NM
                echo >> $LOG_NM
        else
                exit 101
        fi

        for (( j=1; j <= ${NO_RECS}; j++))
        do
                #echo "I am in the second Loop"

                #----Populate the DOMAIN
                export first=abcdefghijklmnopqrstuvwxyz123456789
                export second=zyxwvutsrqponmlkjihgfedcba
                export p=$((RANDOM % ${#second}))
                #export  p=$((RANDOM % ${#j}))
                #echo ${first:$p:10}.${second:$p:10}.com

                #----Populate the Tier1 Category
                export CNT_TIER1=`wc -l $TIER1`
                export TLCNT_TIER1=${#CNT_TIER1}
                export RNDM_TIER1=$((RANDOM % $TLCNT_TIER1))

                #----Populate the Tier2 Category
                export CNT_TIER2=`wc -l $TIER2`
                export TLCNT_TIER2=${#CNT_TIER2}
                export RNDM_TIER2=$((RANDOM % $TLCNT_TIER2))

                #----Populate the NO_OF_DNS_REQUEST
                export CNT_DNS_REQ=`wc -l $DNS_REQ`
                export TLCNT_DNS_REQ=${#CNT_DNS_REQ}
                export RNDM_DNS_REQ=$((RANDOM % $TLCNT_DNS_REQ))

                #----Populate the GNS_PROBE
                export CNT_GNS_PROBE=`wc -l $GNS_PROBE`
                export TLCNT_GNS_PROBE=${#CNT_GNS_PROBE}
                export RNDM_GNS_PROBE=$((RANDOM % $TLCNT_GNS_PROBE))


                #----Actual file generation
                echo `date "+%Y-%m-%d 
		%H:%M:%S"`$DELIMITER$BAN$DELIMITER$IP_1.$IP_2.$IP_3.$IP_4$DELIMITER${first:$p:10}.${second:$p:10}.com$DELIMITER`head -$RNDM_TIER1 
		$TIER1 | tail -1`$DELIMITER`head -$RNDM_TIER2 $TIER2 | tail -1`$DELIMITER`head -$RNDM_DNS_REQ $DNS_REQ | tail -1`$DELIMITER`head 
		-$RNDM_GNS_PROBE $GNS_PROBE | tail -1` >> ${FILE_DIR}/$FILE_NM
                BAN=`expr $BAN + 1`
                IP_4=`expr $IP_4 + 1`
                #echo $BAN > $BAN_FL


                if [[ $IP_4 -eq 999 ]] then
                        IP_4=1
                        BAN=100000001
                fi

        done
                echo File $i generated with $j records...! >> $LOG_NM
                echo File $i generated with $j records...!
                echo >> $LOG_NM
        sleep 1
done

echo File creation completed
echo File creation completed >> $LOG_NM
echo Process ended @ `date "+%Y-%m-%d %H:%M:%S"` >> $LOG_NM