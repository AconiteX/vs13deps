// Copyright (c) Microsoft Corporation. All rights reserved.
// Script for MFC Add Simple Class

function OnPrep(selProj, selObj)
{
	var L_WizardDialogTitle_Text = "MFC 類別精靈";
	return PrepCodeWizard(selProj, L_WizardDialogTitle_Text);
}

function FindInitInstance()
{
    var oClasses = wizard.ProjectObject.CodeModel.GetClassesDerivedFrom("CWinApp");
    if (oClasses != null)
    {
        for (var nCntr = 1; nCntr <= oClasses.Count; nCntr++)
        {
            var oInitInstance = oClasses(nCntr).Functions.Find("InitInstance");
            if (oInitInstance)
                return oInitInstance;
        }
    }
    return false;
}

function OnFinish(selProj, selObj)
{
    var oCM;
    try
    {
        oCM = selProj.CodeModel;

        var strClassName = wizard.FindSymbol("CLASS_NAME");

        var L_TransactionName_Text = "加入 MFC 簡單類別";
        oCM.StartTransaction(L_TransactionName_Text + strClassName);

        var strProjectPath = wizard.FindSymbol("PROJECT_PATH");
        var strTemplatePath = wizard.FindSymbol("TEMPLATES_PATH");
        var strIncludeHeader = wizard.FindSymbol("INCLUDE_HEADER");
        var strHeaderFile = wizard.FindSymbol("HEADER_FILE");
        var strImplFile = wizard.FindSymbol("IMPL_FILE");
        var strDialogID = wizard.FindSymbol("IDD_DIALOG");
        var strTemplateHeader = wizard.FindSymbol("TEMPLATE_HEADER");
        var strTemplateImpl = wizard.FindSymbol("TEMPLATE_IMPL");
        var strHTMLID = wizard.FindSymbol("HTML_ID");
        var strHTMLFile = wizard.FindSymbol("HTML_FILE");
        var strBaseClass = wizard.FindSymbol("BASE_CLASS");
        var bGenDocTemplate = wizard.FindSymbol("GEN_DOCTEMPLATE");
        var bMDI = wizard.FindSymbol("MDI_APP");
        var strDocumentClass = wizard.FindSymbol("DOCUMENT_CLASS");
        var strFrameClass = wizard.FindSymbol("FRAME_CLASS");
        var bAccessibility = wizard.FindSymbol("ACCESSIBILITY");
        var strProjectCPP = GetProjectFile(selProj, "CPP", false, true);

        var bDevice = IsDeviceProject(selProj);

        if (strIncludeHeader != "")
        {
            if (!DoesIncludeExist(selProj, strIncludeHeader, "stdafx.h"))
                oCM.AddInclude(strIncludeHeader, "stdafx.h", vsCMAddPositionEnd);
        }

        var strProjectRC = GetProjectFile(selProj, "RC", true);
        var oResHelper = wizard.ResourceHelper;

        if (wizard.FindSymbol("CREATE_DIALOG"))
        {
            SetResDlgFont();

            var strRCTemplFile = strTemplatePath;
            if (!bDevice)
            {
                if (strBaseClass == "CDHtmlDialog")
                    strRCTemplFile += "\\dhtmldlg.rc";
                else if (strBaseClass == "CFormView")
                    strRCTemplFile += "\\formview.rc";
                else
                    strRCTemplFile += "\\dialog.rc";

                oResHelper.OpenResourceFile(strProjectRC);
                var strTemporaryResourceFile = RenderToTemporaryResourceFile(strRCTemplFile);
                var strSymbolValue = oResHelper.AddResource(strDialogID, strTemporaryResourceFile, "DIALOG");
                if (strSymbolValue == null) return;
                oResHelper.CloseResourceFile();
            }
            else
            {
                var configs = selProj.Object.Configurations;
                var completedResourceFiles = new Array();

                var ProjWiz = new ActiveXObject("ProjWiz.SDProjWiz2.4");

                for (var nCntr = 1; nCntr <= configs.Count; nCntr++)
                {
                    var config = configs.Item(nCntr);
                    var strCurrentResource = GetDeviceResourceFileForConfig(config);

                    if (completedResourceFiles.join(";").indexOf(strCurrentResource) == -1)
                    {
                        var platformName = config.Platform.Name;
                        var symbol = ProjWiz.GetBaseNativePlatformProperty(platformName, "UISymbol");
                        var strPlatformRCTemplFile = strRCTemplFile;

                        if (symbol == "POCKETPC2003_UI_MODEL")
                        {
                            if (strBaseClass == "CFormView")
                                strPlatformRCTemplFile += "\\formviewppc.rc";
                            else
                                strPlatformRCTemplFile += "\\dialogppc.rc";
                        }
                        else if (symbol == "SMARTPHONE2003_UI_MODEL")
                        {
                            if (strBaseClass == "CFormView")
                                strPlatformRCTemplFile += "\\formviewsp.rc";
                            else
                                strPlatformRCTemplFile += "\\dialogsp.rc";
                        }
                        else
                        {
                            if (strBaseClass == "CFormView")
                                strPlatformRCTemplFile += "\\formview.rc";
                            else
                                strPlatformRCTemplFile += "\\dialog.rc";
                        }

                        oResHelper.OpenResourceFile(strCurrentResource);
                        var strTemporaryResourceFile = RenderToTemporaryResourceFile(strPlatformRCTemplFile);
                        var strSymbolValue = oResHelper.AddResource(strDialogID, strTemporaryResourceFile, "DIALOG");
                        oResHelper.CloseResourceFile();
                        completedResourceFiles.push(strCurrentResource);
                    }
                }
            }

            wizard.AddSymbol("IDD_DIALOG", strSymbolValue.split("=").shift());
        }

        if (strBaseClass == "CDHtmlDialog")
        {
            RenderAddTemplate(wizard, "dhtmldlg.htm", strHTMLFile, selObj, false);
            oResHelper.OpenResourceFile(strProjectRC);
            var strSymbolValue = oResHelper.AddResource(strHTMLID, strProjectPath + strHTMLFile, "HTML");
            if (strSymbolValue == null) return;
            oResHelper.CloseResourceFile();
            wizard.AddSymbol("HTML_ID", strSymbolValue.split("=").shift());
        }

        RenderAddTemplate(wizard, strTemplateHeader, strHeaderFile, selObj, true);
        RenderAddTemplate(wizard, strTemplateImpl, strImplFile, selObj, false);

        // look for InitInstance
        var oInitInstance = false;
        if ((strBaseClass == "CFormView" && bGenDocTemplate) || bAccessibility)
            oInitInstance = FindInitInstance();

        // insert AfxOleInit()
        if (bAccessibility && oInitInstance)
        {
            var strBody = oInitInstance.BodyText;
            if (-1 == strBody.indexOf("AfxOleInit"))
            {
                oInitInstance.StartPointOf(vsCMPartBody, vsCMWhereDefinition).CreateEditPoint().Insert("\tAfxOleInit();\r\n");
                oCM.Synchronize();
            }
        }

        if (strBaseClass == "CFormView" && bGenDocTemplate)
        {
            var strMainFrameCaption = wizard.FindSymbol("DOCUMENT_MAIN_FRAME_CAPTION");
            var strFileNewNameShort = wizard.FindSymbol("DOCUMENT_FILE_NEW_NAME_SHORT");
            var strTypeName = wizard.FindSymbol("DOCUMENT_TYPE_NAME");
            var strFilterName = wizard.FindSymbol("DOCUMENT_FILTER_NAME");
            var strFileExt = wizard.FindSymbol("DOCUMENT_FILE_EXTENSION");
            var strFileTypeID = wizard.FindSymbol("DOCUMENT_FILE_TYPE_ID");
            var strFileNewNameLong = wizard.FindSymbol("DOCUMENT_FILE_NEW_NAME_LONG");
            var strTemp = strMainFrameCaption + "\\n" + strFileNewNameShort + "\\n" + strTypeName + "\\n" + strFilterName + "\\n." + strFileExt + "\\n" + strFileTypeID + "\\n" + strFileNewNameLong;

            var strID = CreateSafeName(strClassName).toUpperCase();
            if (strID.charAt(0) == "C")
                strID = strID.substr(1);
            strID = "IDR_" + strID + "_TMPL";

            if (!bDevice)
            {
                oResHelper.OpenResourceFile(strProjectRC);

                var strIconFile;
                if (strClassName.charAt(0) == "C" || strClassName.charAt(0) == "c")
                    strIconFile = strClassName.substr(1) + ".ico";
                else
                    strIconFile = strClassName + ".ico";
                strIconFile = GetUniqueFileName(strProjectPath, strIconFile);
                wizard.RenderTemplate(strTemplatePath + "\\formview.ico", strProjectPath + "res\\" + strIconFile, true); //don't process ico file
                var strSymbolValue = oResHelper.AddResource(strID, strProjectPath + "res\\" + strIconFile, "ICON", "", true);
                if (strSymbolValue == null) return;
                strID = strSymbolValue.split("=").shift();

                var strSymbolValue2 = oResHelper.AddResource(strID, strTemp, "STRING", "", true);
                if (strSymbolValue2 == null) return;

                if (bMDI)
                    strSymbolValue2 = oResHelper.AddResource(strID, strTemplatePath + "\\formviewmdi.rc", "MENU", "#include <afxres.h>", true);
                else
                    strSymbolValue2 = oResHelper.AddResource(strID, strTemplatePath + "\\formviewsdi.rc", "MENU", "#include <afxres.h>", true);
                if (strSymbolValue2 == null) return;

                oResHelper.CloseResourceFile();
            }
            else
            {
                var configs = selProj.Object.Configurations;
                var completedResourceFiles = new Array();

                var ProjWiz = new ActiveXObject("ProjWiz.SDProjWiz2.4");

                for (var nCntr = 1; nCntr <= configs.Count; nCntr++)
                {
                    var config = configs.Item(nCntr);
                    var strCurrentResource = GetDeviceResourceFileForConfig(config);

                    if (completedResourceFiles.join(";").indexOf(strCurrentResource) == -1)
                    {
                        var platformName = config.Platform.Name;
                        var symbol = ProjWiz.GetBaseNativePlatformProperty(platformName, "UISymbol");

                        oResHelper.OpenResourceFile(strCurrentResource);

                        var strIconFile;
                        if (strClassName.charAt(0) == "C" || strClassName.charAt(0) == "c")
                            strIconFile = strClassName.substr(1) + ".ico";
                        else
                            strIconFile = strClassName + ".ico";
                        strIconFile = GetUniqueFileName(strProjectPath, strIconFile);
                        wizard.RenderTemplate(strTemplatePath + "\\formview.ico", strProjectPath + "res\\" + strIconFile, true); //don't process ico file
                        var strSymbolValue = oResHelper.AddResource(strID, strProjectPath + "res\\" + strIconFile, "ICON", "", true);
                        if (strSymbolValue == null) return;
                        strID = strSymbolValue.split("=").shift();

                        var strSymbolValue2 = oResHelper.AddResource(strID, strTemp, "STRING", "", true);
                        if (strSymbolValue == null) return;

                        // We won't add MENU resource for Pocket PC and Smartphone apps since they would also need the 
                        // corresponding RCDATA resource in order to work. RCDATA resource would be mangled by resource editor 
                        // into unreadable hexadecimal data if we put it into .rc file instead of .rc2 file. So we inclined NOT
                        // to add MENU resource unless it's Windows CE apps.
                        if (symbol == "STANDARDSHELL_UI_MODEL")
                        {
                            oResHelper.AddResource(strID, strTemplatePath + "\\formviewsdi.rc", "MENU", "#include <afxres.h>", true);
                        }
                        if (strSymbolValue2 == null) return;

                        oResHelper.CloseResourceFile();
                        completedResourceFiles.push(strCurrentResource);
                    }
                }
            }

            if (oInitInstance)
            {
                if (!DoesIncludeExist(selProj, strHeaderFile, strProjectCPP))
                    oCM.AddInclude('"' + strHeaderFile + '"', strProjectCPP, vsCMAddPositionEnd);

                var strInsert = "\t{\r\n";
                if (bMDI)
                    strInsert += "\t\tCMultiDocTemplate* pNewDocTemplate = new CMultiDocTemplate(\r\n";
                else
                    strInsert += "\t\tCSingleDocTemplate* pNewDocTemplate = new CSingleDocTemplate(\r\n";
                strInsert += "\t\t\t" + strID + ",\r\n";
                strInsert += "\t\t\tRUNTIME_CLASS(" + strDocumentClass + "),\r\n";
                strInsert += "\t\t\tRUNTIME_CLASS(" + strFrameClass + "),\r\n";
                strInsert += "\t\t\tRUNTIME_CLASS(" + strClassName + "));\r\n";
                strInsert += "\t\tAddDocTemplate(pNewDocTemplate);\r\n";
                strInsert += "\t}\r\n\r\n";
                oInitInstance.StartPointOf(vsCMPartBody, vsCMWhereDefinition).CreateEditPoint().Insert(strInsert);
                oCM.Synchronize();
            }
        }

        if (wizard.FindSymbol("AUTOMATION") || wizard.FindSymbol("CREATABLE"))
        {
            var strProjectIDL = GetProjectFile(selProj, "IDL");
            if (!strProjectIDL || strProjectIDL.length == 0)
                strProjectIDL = GetProjectFile(selProj, "ODL");
            if (strProjectIDL.length)
            {
                // Add #include "olectl.h" to strProject.idl
                if (!DoesIncludeExist(selProj, '"olectl.h"', strProjectIDL))
                    oCM.AddInclude('"olectl.h"', strProjectIDL, vsCMAddPositionEnd);

                // Render coclass.idl and insert into strProject.idl
                AddCoclassFromFile(oCM, "coclass.idl");
            }
        }


        oCM.CommitTransaction();

        var newClass = oCM.Classes.Find(strClassName);
        if(newClass)
            newClass.StartPoint.TryToShow(vsPaneShowTop);

    }
    catch (e)
    {
        if (oCM)
            oCM.AbortTransaction();

        if (e.description.length != 0)
            SetErrorInfo(e);
        return e.number
    }
}

// SIG // Begin signature block
// SIG // MIIanQYJKoZIhvcNAQcCoIIajjCCGooCAQExCzAJBgUr
// SIG // DgMCGgUAMGcGCisGAQQBgjcCAQSgWTBXMDIGCisGAQQB
// SIG // gjcCAR4wJAIBAQQQEODJBs441BGiowAQS9NQkAIBAAIB
// SIG // AAIBAAIBAAIBADAhMAkGBSsOAwIaBQAEFJP9FnalZaQm
// SIG // SHqqpE2Je6lz23fIoIIVgjCCBMMwggOroAMCAQICEzMA
// SIG // AAAz5SeGow5KKoAAAAAAADMwDQYJKoZIhvcNAQEFBQAw
// SIG // dzELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
// SIG // b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1p
// SIG // Y3Jvc29mdCBDb3Jwb3JhdGlvbjEhMB8GA1UEAxMYTWlj
// SIG // cm9zb2Z0IFRpbWUtU3RhbXAgUENBMB4XDTEzMDMyNzIw
// SIG // MDgyM1oXDTE0MDYyNzIwMDgyM1owgbMxCzAJBgNVBAYT
// SIG // AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
// SIG // EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
// SIG // cG9yYXRpb24xDTALBgNVBAsTBE1PUFIxJzAlBgNVBAsT
// SIG // Hm5DaXBoZXIgRFNFIEVTTjpGNTI4LTM3NzctOEE3NjEl
// SIG // MCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vy
// SIG // dmljZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
// SIG // ggEBAMreyhkPH5ZWgl/YQjLUCG22ncDC7Xw4q1gzrWuB
// SIG // ULiIIQpdr5ctkFrHwy6yTNRjdFj938WJVNALzP2chBF5
// SIG // rKMhIm0z4K7eJUBFkk4NYwgrizfdTwdq3CrPEFqPV12d
// SIG // PfoXYwLGcD67Iu1bsfcyuuRxvHn/+MvpVz90e+byfXxX
// SIG // WC+s0g6o2YjZQB86IkHiCSYCoMzlJc6MZ4PfRviFTcPa
// SIG // Zh7Hc347tHYXpqWgoHRVqOVgGEFiOMdlRqsEFmZW6vmm
// SIG // y0LPXVRkL4H4zzgADxBr4YMujT5I7ElWSuyaafTLDxD7
// SIG // BzRKYmwBjW7HIITKXNFjmR6OXewPpRZIqmveIS8CAwEA
// SIG // AaOCAQkwggEFMB0GA1UdDgQWBBQAWBs+7cXxBpO+MT02
// SIG // tKwLXTLwgTAfBgNVHSMEGDAWgBQjNPjZUkZwCu1A+3b7
// SIG // syuwwzWzDzBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8v
// SIG // Y3JsLm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0
// SIG // cy9NaWNyb3NvZnRUaW1lU3RhbXBQQ0EuY3JsMFgGCCsG
// SIG // AQUFBwEBBEwwSjBIBggrBgEFBQcwAoY8aHR0cDovL3d3
// SIG // dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNyb3Nv
// SIG // ZnRUaW1lU3RhbXBQQ0EuY3J0MBMGA1UdJQQMMAoGCCsG
// SIG // AQUFBwMIMA0GCSqGSIb3DQEBBQUAA4IBAQAC/+OMA+rv
// SIG // fji5uXyfO1KDpPojONQDuGpZtergb4gD9G9RapU6dYXo
// SIG // HNwHxU6dG6jOJEcUJE81d7GcvCd7j11P/AaLl5f5KZv3
// SIG // QB1SgY52SAN+8psXt67ZWyKRYzsyXzX7xpE8zO8OmYA+
// SIG // BpE4E3oMTL4z27/trUHGfBskfBPcCvxLiiAFHQmJkTkH
// SIG // TiFO3mx8cLur8SCO+Jh4YNyLlM9lvpaQD6CchO1ctXxB
// SIG // oGEtvUNnZRoqgtSniln3MuOj58WNsiK7kijYsIxTj2hH
// SIG // R6HYAbDxYRXEF6Et4zpsT2+vPe7eKbBEy8OSZ7oAzg+O
// SIG // Ee/RAoIxSZSYnVFIeK0d1kC2MIIE7DCCA9SgAwIBAgIT
// SIG // MwAAALARrwqL0Duf3QABAAAAsDANBgkqhkiG9w0BAQUF
// SIG // ADB5MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
// SIG // Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
// SIG // TWljcm9zb2Z0IENvcnBvcmF0aW9uMSMwIQYDVQQDExpN
// SIG // aWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQTAeFw0xMzAx
// SIG // MjQyMjMzMzlaFw0xNDA0MjQyMjMzMzlaMIGDMQswCQYD
// SIG // VQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
// SIG // A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
// SIG // IENvcnBvcmF0aW9uMQ0wCwYDVQQLEwRNT1BSMR4wHAYD
// SIG // VQQDExVNaWNyb3NvZnQgQ29ycG9yYXRpb24wggEiMA0G
// SIG // CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDor1yiIA34
// SIG // KHy8BXt/re7rdqwoUz8620B9s44z5lc/pVEVNFSlz7SL
// SIG // qT+oN+EtUO01Fk7vTXrbE3aIsCzwWVyp6+HXKXXkG4Un
// SIG // m/P4LZ5BNisLQPu+O7q5XHWTFlJLyjPFN7Dz636o9UEV
// SIG // XAhlHSE38Cy6IgsQsRCddyKFhHxPuRuQsPWj/ov0DJpO
// SIG // oPXJCiHiquMBNkf9L4JqgQP1qTXclFed+0vUDoLbOI8S
// SIG // /uPWenSIZOFixCUuKq6dGB8OHrbCryS0DlC83hyTXEmm
// SIG // ebW22875cHsoAYS4KinPv6kFBeHgD3FN/a1cI4Mp68fF
// SIG // SsjoJ4TTfsZDC5UABbFPZXHFAgMBAAGjggFgMIIBXDAT
// SIG // BgNVHSUEDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQUWXGm
// SIG // WjNN2pgHgP+EHr6H+XIyQfIwUQYDVR0RBEowSKRGMEQx
// SIG // DTALBgNVBAsTBE1PUFIxMzAxBgNVBAUTKjMxNTk1KzRm
// SIG // YWYwYjcxLWFkMzctNGFhMy1hNjcxLTc2YmMwNTIzNDRh
// SIG // ZDAfBgNVHSMEGDAWgBTLEejK0rQWWAHJNy4zFha5TJoK
// SIG // HzBWBgNVHR8ETzBNMEugSaBHhkVodHRwOi8vY3JsLm1p
// SIG // Y3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWND
// SIG // b2RTaWdQQ0FfMDgtMzEtMjAxMC5jcmwwWgYIKwYBBQUH
// SIG // AQEETjBMMEoGCCsGAQUFBzAChj5odHRwOi8vd3d3Lm1p
// SIG // Y3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY0NvZFNpZ1BD
// SIG // QV8wOC0zMS0yMDEwLmNydDANBgkqhkiG9w0BAQUFAAOC
// SIG // AQEAMdduKhJXM4HVncbr+TrURE0Inu5e32pbt3nPApy8
// SIG // dmiekKGcC8N/oozxTbqVOfsN4OGb9F0kDxuNiBU6fNut
// SIG // zrPJbLo5LEV9JBFUJjANDf9H6gMH5eRmXSx7nR2pEPoc
// SIG // sHTyT2lrnqkkhNrtlqDfc6TvahqsS2Ke8XzAFH9IzU2y
// SIG // RPnwPJNtQtjofOYXoJtoaAko+QKX7xEDumdSrcHps3Om
// SIG // 0mPNSuI+5PNO/f+h4LsCEztdIN5VP6OukEAxOHUoXgSp
// SIG // Rm3m9Xp5QL0fzehF1a7iXT71dcfmZmNgzNWahIeNJDD3
// SIG // 7zTQYx2xQmdKDku/Og7vtpU6pzjkJZIIpohmgjCCBbww
// SIG // ggOkoAMCAQICCmEzJhoAAAAAADEwDQYJKoZIhvcNAQEF
// SIG // BQAwXzETMBEGCgmSJomT8ixkARkWA2NvbTEZMBcGCgmS
// SIG // JomT8ixkARkWCW1pY3Jvc29mdDEtMCsGA1UEAxMkTWlj
// SIG // cm9zb2Z0IFJvb3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
// SIG // MB4XDTEwMDgzMTIyMTkzMloXDTIwMDgzMTIyMjkzMlow
// SIG // eTELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
// SIG // b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1p
// SIG // Y3Jvc29mdCBDb3Jwb3JhdGlvbjEjMCEGA1UEAxMaTWlj
// SIG // cm9zb2Z0IENvZGUgU2lnbmluZyBQQ0EwggEiMA0GCSqG
// SIG // SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCycllcGTBkvx2a
// SIG // YCAgQpl2U2w+G9ZvzMvx6mv+lxYQ4N86dIMaty+gMuz/
// SIG // 3sJCTiPVcgDbNVcKicquIEn08GisTUuNpb15S3GbRwfa
// SIG // /SXfnXWIz6pzRH/XgdvzvfI2pMlcRdyvrT3gKGiXGqel
// SIG // cnNW8ReU5P01lHKg1nZfHndFg4U4FtBzWwW6Z1KNpbJp
// SIG // L9oZC/6SdCnidi9U3RQwWfjSjWL9y8lfRjFQuScT5EAw
// SIG // z3IpECgixzdOPaAyPZDNoTgGhVxOVoIoKgUyt0vXT2Pn
// SIG // 0i1i8UU956wIAPZGoZ7RW4wmU+h6qkryRs83PDietHdc
// SIG // pReejcsRj1Y8wawJXwPTAgMBAAGjggFeMIIBWjAPBgNV
// SIG // HRMBAf8EBTADAQH/MB0GA1UdDgQWBBTLEejK0rQWWAHJ
// SIG // Ny4zFha5TJoKHzALBgNVHQ8EBAMCAYYwEgYJKwYBBAGC
// SIG // NxUBBAUCAwEAATAjBgkrBgEEAYI3FQIEFgQU/dExTtMm
// SIG // ipXhmGA7qDFvpjy82C0wGQYJKwYBBAGCNxQCBAweCgBT
// SIG // AHUAYgBDAEEwHwYDVR0jBBgwFoAUDqyCYEBWJ5flJRP8
// SIG // KuEKU5VZ5KQwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDov
// SIG // L2NybC5taWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVj
// SIG // dHMvbWljcm9zb2Z0cm9vdGNlcnQuY3JsMFQGCCsGAQUF
// SIG // BwEBBEgwRjBEBggrBgEFBQcwAoY4aHR0cDovL3d3dy5t
// SIG // aWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNyb3NvZnRS
// SIG // b290Q2VydC5jcnQwDQYJKoZIhvcNAQEFBQADggIBAFk5
// SIG // Pn8mRq/rb0CxMrVq6w4vbqhJ9+tfde1MOy3XQ60L/svp
// SIG // LTGjI8x8UJiAIV2sPS9MuqKoVpzjcLu4tPh5tUly9z7q
// SIG // QX/K4QwXaculnCAt+gtQxFbNLeNK0rxw56gNogOlVuC4
// SIG // iktX8pVCnPHz7+7jhh80PLhWmvBTI4UqpIIck+KUBx3y
// SIG // 4k74jKHK6BOlkU7IG9KPcpUqcW2bGvgc8FPWZ8wi/1wd
// SIG // zaKMvSeyeWNWRKJRzfnpo1hW3ZsCRUQvX/TartSCMm78
// SIG // pJUT5Otp56miLL7IKxAOZY6Z2/Wi+hImCWU4lPF6H0q7
// SIG // 0eFW6NB4lhhcyTUWX92THUmOLb6tNEQc7hAVGgBd3TVb
// SIG // Ic6YxwnuhQ6MT20OE049fClInHLR82zKwexwo1eSV32U
// SIG // jaAbSANa98+jZwp0pTbtLS8XyOZyNxL0b7E8Z4L5UrKN
// SIG // MxZlHg6K3RDeZPRvzkbU0xfpecQEtNP7LN8fip6sCvsT
// SIG // J0Ct5PnhqX9GuwdgR2VgQE6wQuxO7bN2edgKNAltHIAx
// SIG // H+IOVN3lofvlRxCtZJj/UBYufL8FIXrilUEnacOTj5XJ
// SIG // jdibIa4NXJzwoq6GaIMMai27dmsAHZat8hZ79haDJLmI
// SIG // z2qoRzEvmtzjcT3XAH5iR9HOiMm4GPoOco3Boz2vAkBq
// SIG // /2mbluIQqBC0N1AI1sM9MIIGBzCCA++gAwIBAgIKYRZo
// SIG // NAAAAAAAHDANBgkqhkiG9w0BAQUFADBfMRMwEQYKCZIm
// SIG // iZPyLGQBGRYDY29tMRkwFwYKCZImiZPyLGQBGRYJbWlj
// SIG // cm9zb2Z0MS0wKwYDVQQDEyRNaWNyb3NvZnQgUm9vdCBD
// SIG // ZXJ0aWZpY2F0ZSBBdXRob3JpdHkwHhcNMDcwNDAzMTI1
// SIG // MzA5WhcNMjEwNDAzMTMwMzA5WjB3MQswCQYDVQQGEwJV
// SIG // UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
// SIG // UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
// SIG // cmF0aW9uMSEwHwYDVQQDExhNaWNyb3NvZnQgVGltZS1T
// SIG // dGFtcCBQQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
// SIG // ggEKAoIBAQCfoWyx39tIkip8ay4Z4b3i48WZUSNQrc7d
// SIG // GE4kD+7Rp9FMrXQwIBHrB9VUlRVJlBtCkq6YXDAm2gBr
// SIG // 6Hu97IkHD/cOBJjwicwfyzMkh53y9GccLPx754gd6udO
// SIG // o6HBI1PKjfpFzwnQXq/QsEIEovmmbJNn1yjcRlOwhtDl
// SIG // KEYuJ6yGT1VSDOQDLPtqkJAwbofzWTCd+n7Wl7PoIZd+
// SIG // +NIT8wi3U21StEWQn0gASkdmEScpZqiX5NMGgUqi+YSn
// SIG // EUcUCYKfhO1VeP4Bmh1QCIUAEDBG7bfeI0a7xC1Un68e
// SIG // eEExd8yb3zuDk6FhArUdDbH895uyAc4iS1T/+QXDwiAL
// SIG // AgMBAAGjggGrMIIBpzAPBgNVHRMBAf8EBTADAQH/MB0G
// SIG // A1UdDgQWBBQjNPjZUkZwCu1A+3b7syuwwzWzDzALBgNV
// SIG // HQ8EBAMCAYYwEAYJKwYBBAGCNxUBBAMCAQAwgZgGA1Ud
// SIG // IwSBkDCBjYAUDqyCYEBWJ5flJRP8KuEKU5VZ5KShY6Rh
// SIG // MF8xEzARBgoJkiaJk/IsZAEZFgNjb20xGTAXBgoJkiaJ
// SIG // k/IsZAEZFgltaWNyb3NvZnQxLTArBgNVBAMTJE1pY3Jv
// SIG // c29mdCBSb290IENlcnRpZmljYXRlIEF1dGhvcml0eYIQ
// SIG // ea0WoUqgpa1Mc1j0BxMuZTBQBgNVHR8ESTBHMEWgQ6BB
// SIG // hj9odHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2Ny
// SIG // bC9wcm9kdWN0cy9taWNyb3NvZnRyb290Y2VydC5jcmww
// SIG // VAYIKwYBBQUHAQEESDBGMEQGCCsGAQUFBzAChjhodHRw
// SIG // Oi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01p
// SIG // Y3Jvc29mdFJvb3RDZXJ0LmNydDATBgNVHSUEDDAKBggr
// SIG // BgEFBQcDCDANBgkqhkiG9w0BAQUFAAOCAgEAEJeKw1wD
// SIG // RDbd6bStd9vOeVFNAbEudHFbbQwTq86+e4+4LtQSooxt
// SIG // YrhXAstOIBNQmd16QOJXu69YmhzhHQGGrLt48ovQ7DsB
// SIG // 7uK+jwoFyI1I4vBTFd1Pq5Lk541q1YDB5pTyBi+FA+mR
// SIG // KiQicPv2/OR4mS4N9wficLwYTp2OawpylbihOZxnLcVR
// SIG // DupiXD8WmIsgP+IHGjL5zDFKdjE9K3ILyOpwPf+FChPf
// SIG // wgphjvDXuBfrTot/xTUrXqO/67x9C0J71FNyIe4wyrt4
// SIG // ZVxbARcKFA7S2hSY9Ty5ZlizLS/n+YWGzFFW6J1wlGys
// SIG // OUzU9nm/qhh6YinvopspNAZ3GmLJPR5tH4LwC8csu89D
// SIG // s+X57H2146SodDW4TsVxIxImdgs8UoxxWkZDFLyzs7BN
// SIG // Z8ifQv+AeSGAnhUwZuhCEl4ayJ4iIdBD6Svpu/RIzCzU
// SIG // 2DKATCYqSCRfWupW76bemZ3KOm+9gSd0BhHudiG/m4LB
// SIG // J1S2sWo9iaF2YbRuoROmv6pH8BJv/YoybLL+31HIjCPJ
// SIG // Zr2dHYcSZAI9La9Zj7jkIeW1sMpjtHhUBdRBLlCslLCl
// SIG // eKuzoJZ1GtmShxN1Ii8yqAhuoFuMJb+g74TKIdbrHk/J
// SIG // mu5J4PcBZW+JC33Iacjmbuqnl84xKf8OxVtc2E0bodj6
// SIG // L54/LlUWa8kTo/0xggSHMIIEgwIBATCBkDB5MQswCQYD
// SIG // VQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
// SIG // A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
// SIG // IENvcnBvcmF0aW9uMSMwIQYDVQQDExpNaWNyb3NvZnQg
// SIG // Q29kZSBTaWduaW5nIFBDQQITMwAAALARrwqL0Duf3QAB
// SIG // AAAAsDAJBgUrDgMCGgUAoIGgMBkGCSqGSIb3DQEJAzEM
// SIG // BgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgor
// SIG // BgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBSvO6bxmEuk
// SIG // hsUmU1uanwAHdp4KaTBABgorBgEEAYI3AgEMMTIwMKAW
// SIG // gBQAZABlAGYAYQB1AGwAdAAuAGoAc6EWgBRodHRwOi8v
// SIG // bWljcm9zb2Z0LmNvbTANBgkqhkiG9w0BAQEFAASCAQAI
// SIG // nT98dq/i1Or4r5lKKLZBqPQF8FqDjtdanc5gG0JdzMhK
// SIG // SK3fT8WHO0g9E/jWlV9fNhqfso3iq0r7vECuCRanTBfC
// SIG // 7+4Tgg9kbE/+HZp9VibbR2wP15Z6gm3GNoQOE2iXfkuu
// SIG // 0mtqPDVA6auAST64RMdNqbZHh4kWhkYcecWaRT+WSmP3
// SIG // 3XpqbI8I8LGV9clsVhOKIpsBY2nnBsN2AjW1AkPfhUBu
// SIG // 4gubVaVdF0kck+Mw+RGRZxwdQrwy8hDpQCmk6ivEde9e
// SIG // n06qIQk0YaARIq3DohfYnLQbUhEtRrfM2c+653Gjw3C+
// SIG // iUazNsBOf7BE82RiFT/Ji20iFgWIl+FYoYICKDCCAiQG
// SIG // CSqGSIb3DQEJBjGCAhUwggIRAgEBMIGOMHcxCzAJBgNV
// SIG // BAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYD
// SIG // VQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQg
// SIG // Q29ycG9yYXRpb24xITAfBgNVBAMTGE1pY3Jvc29mdCBU
// SIG // aW1lLVN0YW1wIFBDQQITMwAAADPlJ4ajDkoqgAAAAAAA
// SIG // MzAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqG
// SIG // SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTMxMDA1MDk1
// SIG // NjEwWjAjBgkqhkiG9w0BCQQxFgQU+NjB8J27Ti3yyCMN
// SIG // tD6e7rhB+0cwDQYJKoZIhvcNAQEFBQAEggEAor2ig3v/
// SIG // 5vKML3y2ag+3zBK0zuSJ3qZBf38n+oSV8JVx/bxqdXLp
// SIG // LkGXSfxGLV3lPqdwsx0cAKXrSng4cDoEXqJNpxwr6pto
// SIG // rGezX3ARAW5OgSoRR0HgieRDnZspl1CMtLHsgYgOPM23
// SIG // ueca1gj2PIs2IyfrFt2j2fPrxAXGOM0hNgEyqpVzKK52
// SIG // r9LKeWm1fXR/xTnK1rcYxlwzp+L6CSIk+qzuzL2irPBp
// SIG // tPdr3egxNOS/tcDBNoI8kehckHEL4dZyOFqEGhN3yOa7
// SIG // fw/k3oaCMGw4JUM7clvCfBVgf69sSouu4SiHsT2nNU6+
// SIG // YX3xYPWcfwYHKgohC2xqCI38PQ==
// SIG // End signature block
