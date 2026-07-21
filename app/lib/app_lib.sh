#!/bin/bash

STR_EMAIL_FROM=${EMAIL_FROM}
STR_EMAIL_TO=${EMAIL_TO}
STR_TEST_REPORT_NAME=test_report

function_send_email()
{
    MAIL_BODY=${1}
    MAIL_FROM=${2}
    MAIL_TO=${3}
    MAIL_SUBJ="${4}"
    MAIL_CC=${5}
    MAIL_BCC=${6}
    MAIL_PART=$(uuidgen) ## Generates Unique ID
    MAIL_PART_BODY=$(uuidgen) ## Generates Unique ID
    (
        echo "Date: $(date -R)"
        echo "To: ${MAIL_TO}"
        echo "From: \"${FROM_NAME}\" <${FROM_MAIL}>"
        echo "Cc: ${MAIL_CC}"
        echo "Bcc: ${MAIL_BCC}"
        echo "Subject: ${MAIL_SUBJ}"
        echo "MIME-Version: 1.0"
        echo "Content-Type: multipart/mixed; boundary=\"${MAIL_PART}\""
        echo "--${MAIL_PART}"
        echo "Content-Type: multipart/alternative; boundary=\"${MAIL_PART_BODY}\""
        echo ""
        echo "--${MAIL_PART_BODY}"
        echo "Content-Type: text/html; charset=ISO-8859-1"
        echo "Content-Disposition: inline"
        echo ""
        cat ${MAIL_BODY}
        echo ""
        for ATTACH in "${ARGS[@]}"
        do
            echo "--${MAIL_PART}"
            echo "Content-Type: application/pdf; charset=ISO-8859-1; name=`basename ${ATTACH}`"
            echo "Content-Transfer-Encoding: base64"
            echo "Content-Disposition: attachment; filename=`basename ${ATTACH}`"
            echo ""
            base64 < "${ATTACH}"
        done
    ) | sendmail ${MAIL_TO}
}