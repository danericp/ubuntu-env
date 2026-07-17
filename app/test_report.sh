#!/bin/bash

. ./lib/app_lib.sh

OUT_HTML=./test_report.html>${OUT_HTML}

echo "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://w3.org\">">>${OUT_HTML}
echo "<html>">>${OUT_HTML}
echo "<head class="page-header">">>${OUT_HTML}
bash ./lib/app_css.sh ${OUT_HTML}
echo "</head><body>">>${OUT_HTML}
echo "<table class=minimal-table>">>${OUT_HTML}
echo "<thead><tr>">>${OUT_HTML}
echo "<th colspan=6> tb_users </th>">>${OUT_HTML}
echo "</tr></thead>">>${OUT_HTML}
echo "<tbody><tr>">>${OUT_HTML}
echo "<th> ID </th>">>${OUT_HTML}
echo "<th> First Name </th>">>${OUT_HTML}
echo "<th> Last Name </th>">>${OUT_HTML}
echo "<th> DOB </th>">>${OUT_HTML}
echo "<th> Email </th>">>${OUT_HTML}
echo "<th> Gender </th>">>${OUT_HTML}
echo "</tr><tr>">>${OUT_HTML}
echo "<td> 1 </td>">>${OUT_HTML}
echo "<td> Luffy </td>">>${OUT_HTML}
echo "<td> Monkey </td>">>${OUT_HTML}
echo "<td> May 5 </td>">>${OUT_HTML}
echo "<td> one.piece@gmail.com </td>">>${OUT_HTML}
echo "<td> m </td>">>${OUT_HTML}
echo "</tr></tbody>">>${OUT_HTML}
echo "</table><br>">>${OUT_HTML}
echo "</html>">>${OUT_HTML}

ARGS+=("fake_users.csv")
function_send_email ${OUT_HTML} daneric.pelayo@gmail.com daneric.pelayo@outlook.com "Test Subject"