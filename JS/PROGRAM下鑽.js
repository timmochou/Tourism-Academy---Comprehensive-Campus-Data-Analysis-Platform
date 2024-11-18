//PROGRAM 下鑽
var a = FR.serverURL;
duchamp.doHyperlinkByGet({
    "url": 'https://freportuat.ift.edu.mo/webroot/decision/view/report?viewlet=IFTM/r012.cpt&op=write',
    "target": "_dialog",
    "para": {
        "P_AY": P_AY,
        "P_YEAR": P_YEAR,
        "BTN_TYPE": BTN_TYPE
    },
    "feature": {
        "width": 1000,
        "height": 600,
        "title": BTN_TYPE === "1" ? "Admission by School Academic Year Trend" : BTN_TYPE === "2" ? "Admission by School Calendar Year Trend" : "Default Title"
    }
});



var a = FR.serverURL;
duchamp.doHyperlinkByGet({
    "url": 'https://freportuat.ift.edu.mo/webroot/decision/view/report?viewlet=IFTM/r012.cpt&op=write',
    "target": "_dialog",
    "para": {
        "P_AY": P_AY,
        "P_YEAR": P_YEAR,
        "BTN_TYPE": BTN_TYPE
    },
    "feature": {
        "width": 1000,
        "height": 600,
        "title": BTN_TYPE === "1" ? "Admission by School Academic Year Trend" : BTN_TYPE === "2" ? "Admission by School Calendar Year Trend" : "Default Title"
    }
});



var a =FR.serverURL;
duchamp.doHyperlinkByGet({
	"url":'https://freportuat.ift.edu.mo/webroot/decision/view/report?viewlet=IFTM/r009.cpt&op=write',
	"target":"_dialog",
        "para":{
               "P_AY" : P_AY
		},
"feature":{
		"width":1000,
		"height":600,
		"title":"Students by School Yearly Trend (Academic year)"
		}
	})