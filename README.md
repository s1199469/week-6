# IAC LAB -WEEK-6
-------
## synopsis
### Deliverables:
- 1x VM met Docker, gehost op ESXi
- 1x VM met Docker, gehost in Azure
- beide servers bereikbaar met SSH
- "Hello World" demo container
- er is een Testomgeving en een Productieomgeving

*Commando's voor Terraform deployment*
Config files voor test staan in /test

Config files voor Productie staan in /prod

terraform -chdir=test init

terraform -chdir=test plan -var-file week6-test.tfvars

terraform -chdir=test apply -var-file week6-test.tfvars -auto-approve

terraform -chdir=test destroy -var-file week6-test.tfvars -auto-approve

terraform -chdir=prod plan -var-file week6-prod.tfvars

terraform -chdir=prod apply -var-file week6-prod.tfvars -auto-approve

terraform -chdir=prod destroy -var-file week6-prod.tfvars -auto-approve

# Testen met Ansible playbooks
----


# uitgangspunten:
- Test en Productie kunnen met Terraform los van elkaar worden uitgerold
- Hergebruik zoveel mogelijk Terraform Manifest en Ansible playbooks uit vorige opdrachten (Lab 2A en 2B)
- Gebruik zoveel mogelijk Ansible modules voor Docker in plaats van apt en shell. Het moet een ansible-galaxy role zijn die zelf is toegevoegd
- De deployment wordt uitgevoerd met een Github-actions workflow
- Verwijderen van de uitgerolde infrastructuur kan met een workflow
- Aanpassingen worden in aparte branches gedaan, niet in main. Branches worden gemerged in *main* 


*https://medium.com/@18bhavyasharma/using-ansible-to-manage-docker-containers-b49aa32fa27f*


----

# toelichting
## Test en Productie
De terraform configuratiefiles staan in de mappen /test en /Productie

De deployment wordt aangeroepen uit de root waarbij de optie -chdir=test | productie ervoor zorgt dat de betreffende subdirectory de werkmap wordt. Terraform pakt alle configuraties uit deze werkmap.
Ik heb eerst geprobeerd te werken met één main.tf in de root maar bij de deployment van productie werden de VM's vervangen. Dit komt omdat iedere resource in main.tf een letterlijke "identifier" heeft (bijv. VM-1). Het is misschien mogelijk maar ik heb binnen een redelijke tijd geen oplossing kunnen vinden. Bijkomend voordeel van een apart main.tf in /test is dat wijzigingen in main.tf getest kunnen worden zonder dat het invloed heeft op de bestaande productie-deployment.

----

# ansible-galaxy role voor Docker installatie
De ansible playbook files staan in de subdirectory /Ansible
1. Op deployment VM een basisconfiguratie uitgevoerd met het commando: **ansible-galaxy init my-docker**
2. De opgebouwde folderstructuur gekopieerd naar het lokale werkstation met MobaXterm (Er is een probleem met git waardoor het niet met een git push via de repo kan) 
3. Op de website van Docker de installatiescripts gedownload en met AI laten omzetten in een ansible-playbook (install_docker.yml)

* https://chat.mistral.ai/chat/d758136c-1685-4dc8-9f99-a9f5858c6b56 *

4. Het playbook gecontroleerd, gechecked met --check en getest op in mijn sandbox deployment. De playbook is geschikt bevonden 
5. De inhoud van de playbook gekopieerd naar \my-docker\tasks\main.tf in de lokale repo
6. nieuwe repo gemaakt voor de role: **s1199469/ansible_role_docker**
7. Inhoud van \my-docker gekopieerd naar de nieuwe repo
8. my-docker repo gepusht naar Github

# toevoegen aan ansible-galaxy
1. Log in op Ansible galaxy
2. ga naar **role Namespaces**
3. ga naar de namespace (heeft de username als naam)
4. kies import role
5. Vul de naam van de repository in (let op: de naam **ansible_role_docker** is voldoende)
6. Klik op **import**
7. Bij roles>import log staan waarschuwingen omdat ansible-galaxy een syntax check doet. Corrigeer eventueel in de broncode, push deze naar de repo en klik in ansible galaxy op **Import new version** om bij te werken
8. Voer op de deployment server het volgende commando uit: **ansible-galaxy role install s1199469/docker**

----
# bijzonderheden
- De Esxi provider ondersteunt, in tegenstelling tot de azurerm provider, niet het kopiëren van een ssh public-key naar de host. De key wordt daarom aangemaakt met cloud-init.

- Als een ansible playbook wordt gewijzigd dan moet de VM deployment opnieuw worden uitgevoerd (destroy-apply). De wijzigingen worden anders niet naar de _work folder van de self-hosted runner gekopieerd


