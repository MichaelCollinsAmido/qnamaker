# $AuthoringKey = "%REPLACE_ME%"
# $knowledgebaseID = "%REPLACE_ME%"

#Backup
$Param = @{
    Uri = ("https://westus.api.cognitive.microsoft.com/qnamaker/v5.0-preview.1/knowledgebases/$knowledgebaseID/Test/qna")
    Method = 'get'
    Headers = @{
        'Content-type' = 'application/json'
        'Ocp-Apim-Subscription-Key' = $AuthoringKey
    }
}

$backup = Invoke-RestMethod @Param 

$backup | ConvertTo-Json -Depth 5| Out-File "dl.json"


#Restore
$json = Get-Content "dl.json"

$Param = @{
    Uri = ("https://westus.api.cognitive.microsoft.com/qnamaker/v5.0-preview.1/knowledgebases/$knowledgebaseID")
    Method = 'put'
    Headers = @{
        'Content-type' = 'application/json'
        'Ocp-Apim-Subscription-Key' = $AuthoringKey
    }
}

$restore = Invoke-RestMethod @Param -Body $json

$restore