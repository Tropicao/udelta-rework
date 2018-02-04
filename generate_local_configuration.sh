#!/bin/sh

function generate_repetier_values_xml ()
{
    HOST_CONFIG="$DIR/eMotionTech/repetier/values.xml"
    echo "<values>" > $HOST_CONFIG
    echo "<value name=\"logEnabled\"" >> $HOST_CONFIG
    echo "type=\"int\">0</value>" >> $HOST_CONFIG
    echo "<value name=\"reduceToolbarSize\"" >> $HOST_CONFIG
    echo "type=\"int\">0</value>" >> $HOST_CONFIG
    echo "<value name=\"workdir\"" >> $HOST_CONFIG
    echo "type=\"string\">$DIR/.local/share/RepetierHost</value>" >> $HOST_CONFIG
    echo "<value name=\"demoModelShown\"" >> $HOST_CONFIG
    echo "type=\"int\">1</value>" >> $HOST_CONFIG
    echo "<value name=\"currentPrinter\"" >> $HOST_CONFIG
    echo "type=\"string\">MicroDelta Rework</value>" >> $HOST_CONFIG
    echo "<value name=\"installPath\"" >> $HOST_CONFIG
    echo "type=\"string\">$DIR/RepetierHost</value>" >> $HOST_CONFIG
    echo "<value name=\"disableQualityReduction\"" >> $HOST_CONFIG
    echo "type=\"int\">0</value>" >> $HOST_CONFIG
    echo "<value name=\"showHelpBubbles\"" >> $HOST_CONFIG
    echo "type=\"int\">1</value>" >> $HOST_CONFIG
    echo "</values>" >> $HOST_CONFIG
}

functions generate_window_values_xml ()
{
    HOST_CONFIG="$DIR/eMotionTech/repetier/window/values.xml"
    echo "<values>" > $HOST_CONFIG
    echo "<value name=\"importScaleFactor\"" >> $HOST_CONFIG
    echo "type=\"string\">1</value>" >> $HOST_CONFIG
    echo "<value name=\"printerIdShow\"" >> $HOST_CONFIG
    echo "type=\"int\">0</value>" >> $HOST_CONFIG
    echo "<value name=\"onOffImageOffset\"" >> $HOST_CONFIG
    echo "type=\"int\">0</value>" >> $HOST_CONFIG
    echo "<value name=\"fileHistory\"" >> $HOST_CONFIG
    echo "type=\"string\">$DIR/data/models/tablet.amf</value>" >> $HOST_CONFIG
    echo "<value name=\"mainWindow\"" >> $HOST_CONFIG
    echo "type=\"string\">0|44|1026|557|Maximized</value>" >> $HOST_CONFIG
    echo "<value name=\"logSplitterDistance\"" >> $HOST_CONFIG
    echo "type=\"int\">548</value>" >> $HOST_CONFIG
    echo "<value name=\"lastUpdateCheck\"" >> $HOST_CONFIG
    echo "type=\"string\">63614216925</value>" >> $HOST_CONFIG
    echo "<value name=\"mainWindowScreen\"" >> $HOST_CONFIG
    echo "type=\"int\">0</value>" >> $HOST_CONFIG
    echo "<value name=\"printerSettingsWindow\"" >> $HOST_CONFIG
    echo "type=\"string\">66|66</value>" >> $HOST_CONFIG
    echo "<value name=\"printerSettingsWindowScreen\"" >> $HOST_CONFIG
    echo "type=\"int\">0</value>" >> $HOST_CONFIG
    echo "<value name=\"infoEditSplitterDistance\"" >> $HOST_CONFIG
    echo "type=\"int\">505</value>" >> $HOST_CONFIG
    echo "<value name=\"logShow\"" >> $HOST_CONFIG
    echo "type=\"int\">1</value>" >> $HOST_CONFIG
    echo "</values>" >> $HOST_CONFIG
}

generate_repetier_values_xml
generate_window_values_xml
