#!/bin/bash

ARG_FILE=${1}

cat<<EOF>>${ARG_FILE}
<style type="text/css">
    .minimal-table {
    # width: 100%;
    border-collapse: collapse; /* Merges cell borders into a clean single line */
    font-family: sans-serif;
    }

    .minimal-table th, 
    .minimal-table td {
    padding: 12px;
    text-align: left; /* Left-aligned for better legibility */
    border-bottom: 1px solid #e0e0e0;
    }

    .minimal-table th {
    font-weight: 600;
    color: #333333;
    }
</style>
EOF