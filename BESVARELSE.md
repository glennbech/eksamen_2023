# Besvarelse kandidat-2020
## Oppgave 1 Kjells Python kode
### Del A

* ***Fjerne hardkoding av S3 bucket navnet app.py koden, slik at den leser verdien "BUCKET_NAME" fra en miljøvariabel.***

Her Her antok jeg at app.py koden skulle hente ut variabelen fra template yaml

```python
BUCKET_NAME = os.environ.get("BucketName")
```

```yml
Bucket:
    Type: AWS::S3::Bucket
    Properties:
      BucketName: "kandidat-2020"

```

<br>

* ***For hver push til main branch, skal arbeidsflyten bygge og deploye Lambda-funksjonen***
* ***Som respons på en push til en annen branch en main, skal applikasjonen kun bygges***
  
GitHub Action fila ligger [her](.github/workflows/sam-deploy.yml)

* ***Forklar hva sensor må gjøre for å få GitHub Actions workflow til å kjøre i sin egen GitHub-konto***

For at sensor skal kjøre workflow fra sin egen fork må sensor lage egne Repository Secrets
1. Gå in på AWS IAM
2. Trykk Create Access Keys
3. Kopier Key og Secret Key
4. Gå til GitHub Repoet og legg til «New Repository Secrets»

![AWS IAM]()
![Retrieve Access Keys]()
![GitHub Repo Secret]()

### Del B
* ***Lag en Dockerfile som bygger et container image du kan bruke for å kjøre python koden***

Dockerfilen ligger  [her](kjell/hello_world/Dockerfile)

## Oppgave 2 Overgang til Java og Spring Boot
### Del A
* ***Lag en Dockerfile for Java-appliksjonen. Du skal lage en multi stage Dockerfile som både kompilerer og kjører applikasjonen***

Dockerfila ligger [her](/Dockerfile)


### Del B
* ***Lag en GitHub actions workflow som ved hver push til main branch lager og publiserer et nytt Container image til et ECR repository.***
* ***Workflow skal kompilere og bygge et nytt container image, men ikke publisere image til ECR dersom branch er noe annet en main.***
* ***Du må selv lage et ECR repository i AWS miljøet, du trenger ikke automatisere prosessen med å lage dette.***
* ***Container image skal ha en tag som er lik commit-hash i Git, for eksempel: glenn-ppe:b2572585e.***
* ***Den siste versjonen av container image som blir pushet til ECR, skal i tillegg få en tag "latest"***

GitHub Action Workflow fila ligger [her](.github/workflows/docker.yml)

## Oppgave 3- Terraform, AWS Apprunner og Infrastruktur som kode
### Del A
* ***Fjern hardkodingen av service_name, slik at du kan bruke ditt kandidatnummer eller noe annet som service navn***
* ***Se etter andre hard-kodede verdier og se om du kan forbedre kodekvaliteten***
* ***Se på dokumentasjonen til aws_apprunner_service ressursen, og reduser CPU til 256, og Memory til 1024 (defaultverdiene er høyere***

Her la jeg til Kandidat nr i [variables.tf](/variables.tf)
La til image i [variables.tf](/variables.tf)

```tf
variable "kandidat" {
  type = string
  #default = "candidate-2020"
}

variable "image" {
  type = string
}
```

Fik feil meldinger med memory og cpu, har kommentert ut koden som ikke fungerte for meg

```tf
  instance_configuration {
    instance_role_arn = aws_iam_role.role_for_apprunner_service.arn
    #cpu = "256"
    #memory = "1024"
  }
```
![Memory]()
![Cpu]()


### Del B
* ***Utvid din GitHub Actions workflow som lager et Docker image, til også å kjøre terraformkoden***
* ***På hver push til main, skal Terraformkoden kjøres etter jobber som bygger Docker container image***
* ***Du må lege til Terraform provider og backend-konfigurasjon. Dette har Kjell glemt. Du kan bruke samme S3 bucket som vi har brukt til det formålet i øvingene***
* ***Beskriv også hvilke endringer, om noen, sensor må gjøre i sin fork, GitHub Actions workflow eller kode for å få denne til å kjøre i sin fork***

Terraform provider og backend-konfigurasjon ligger i [provider.tf](/provider.tf)

## Oppgave 4 Feedback

## Oppgave 5 Drøfteoppgave
### Del A Kontinuerlig Integrering

***Forklar hva kontinuerlig integrasjon (CI) er og diskuter dens betydning i utviklingsprosessen. I ditt svar, vennligst inkluder***
* ***En definisjon av kontinuerlig integrasjon***

Kontinuerlig integrasjon (CI) er en automatisert prosess hvor kodeendringer fra flere utviklere «merges» inn i et sentralt repository/prosjekt. Dette lar utviklere ofte slå sammen kodeendringer til et sentralt repository hvor koden bygges og testes og deretter kjøres. CI er designet for å optimalisere tempoet i programvareleveransen

Et godt eksempel på CI er bilde fra Leksjon 2 «Flow» Slide 19
![Flow]()

* ***Fordelene med å bruke CI i et utviklingsprosjekt - hvordan CI kan forbedre kodekvaliteten og effektivisere utviklingsprosessen***

Uten CI hadde det vært utrolig vanskelig å utvikle sammen i større prosjekter. Forestill deg et team på 15 utviklere som arbeider på et prosjekt, og en av dem oppdager bug på linje 17503 ut av 50000. Uten CI ville hele teamet måtte stoppe med det de holdt på med og vente på at buggen blir fikset også måtte alle hente ut sist oppdatert versjon. Dette gjør at ingen kan jobbe individuelt og hele prosessen er svært ueffektivt, man kunne nesten like gjerne bare hatt en utvikler. Med en vellstrukturert CI prosess kan hver utvikler jobbe individuelt uavhengig av hverandre, hver utvikler kan lage en «Feauture Branch» av main koden og jobbe individuelt uten å ødelegge for andre. Og med automatiserte tester og peer review får man rask tilbakemelding og oppdager feil i koden med en gang, dette gjør at vi får økt kodekvalitet og effektiv utviklingsprosess.

* ***Hvordan jobber vi med CI i GitHub rent praktisk? For eskempel i et utviklingsteam på fire/fem utivklere?***

Si man har 5 utviklere som skal utbedre backend koden for handlekurv og ordre prosessen til Komplett.no. Da har man gjerne en «backlog» som består av flere oppgaver som skal utføres. Disse oppgavene blir delt ut til de 5 utviklerne, og med CI kan hver utvikler lage feauture branches av main koden og utvikle individuelt og samtidig parallelt med hverandre. Når oppgavene er utført kan hver utvikler pushe koden sin til main uten å forstyrre for de andre. Med GitHub Workflows og andre automatiserte tester, får man raskt tilbakemelding dersom det er feil i koden. I tillegg bruke man også ofte peer reviews slik at man får god kodekvalitet.


### Del B Sammenligning av Scrum/Smidig og DevOps fra et Utviklers Perspektiv
#### 1. Scrum Scrum/Smidig Metodikk:
* ***Hvordan jobber vi med CI i GitHub rent praktisk? For eskempel i et utviklingsteam på fire/fem utivklere?***

Scrum er et rammeverk som hjelper utviklere å utvikle, levere og opprettholde et utviklings prosjekt. Hovedtrekkene til Scrum er å bryte ned store prosjekt ned i mindre oppgaver, disse oppgavene settes i det som kalles en «Product Backlog».
Kjernen i Scrum er «Scrum Sprints». I en sprint, velger utviklerne (eller scrum master) hvilke backlog items som skal med i sprint backlogen. Lengden på en Sprint varierer, men er ofte 1 uke opptil 1 måned. En sprint består av…
-	Sprint Planning
o	Her velger utviklerne eller scrum master hvilke «backlog items» eller utviklings oppgaver som skal med i sprint uka. Og her blir utviklings laget enige om hvem som skal gjøre hva og hvilke kriterier som må oppfylles
-	Implementasjon
o	Selve kode prosessen, her tar man i bruk DevOps prinsipper som CI/CD for å optimalisere utviklings prosessen. Under implementasjons fasen gjennomfører man «Daily Scrums» der man forteller resten av utviklings teamet hva man holder på med og hva man planlegger den dagen.
-	Sprint Review
o	Her tar man en gjennomgang av hva som ble gjort kode messig i scrum uka, også oppdaterer man product backlogen. 
-	Sprint retrospective
o	Her tar man en gjennomgang av selve sprint prosessen, og finner ut om det er noe man kan gjøre for å øke kvaliteten og effektiviteten på sprint prosessen.
Når Sprint retrospective er ferdig, begynner hele prosessen på nytt.
Bildet er hentet fra Wrike.com
![wrike]()


* ***Diskuter eventuelle utfordringer og styrker ved å bruke Scrum/Smidig i programvareutviklingsprosjekter***
* 
