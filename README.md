# IAC LAB -WEEK-6
-------
# Deliverables:
- 1x VM met Docker, gehost op ESXi
- 1x VM met Docker, gehost in Azure
- beide servers bereikbaar met SSH
- "Hello World" demo container

# uitgangspunten:
- Hergebruik zoveel mogelijk Terraform Manifest en Ansible playbooks uit vorige opdrachten (Lab 2A en 2B)
- Gebruik zoveel mogelijk Ansible modules voor Docker in plaats van apt en shell. Het moet een ansible-galaxy role zijn die zelf is toegevoegd
- De deployment wordt uitgevoerd met een Github-actions workflow
- Verwijderen van de uitgerolde infrastructuur kan met een workflow
- Aanpassingen worden in aparte branches gedaan, niet in main. Branches worden gemerged in *main* 


https://medium.com/@18bhavyasharma/using-ansible-to-manage-docker-containers-b49aa32fa27f
----

## toelichting
# ansible-galaxy role voor Docker installlatie
1. Op deployment VM een basisinrichting uitgevoerd met het commando: **ansible-galaxy init my-docker**
2. De opgebouwde folderstructuur gekopieerd naar het lokale werkstation met MobaXterm (Er is een probleem met git waardoor het niet met een git push via de repo kan) 
3. Op de website van Docker de installatiescripts gedownload en met AI laten omzetten in een ansible-playbook (install_docker.yml)

* https://chat.mistral.ai/chat/d758136c-1685-4dc8-9f99-a9f5858c6b56 *

4. Het playbook gecontroleerd, gechecked met --check en getest op in mijn sandbox deployment. De playbook is geschikt bevonden 
5. De inhoud van de playbook gekopieerd naar \my-docker\tasks\main.tf in de lokale repo
6. nieuwe repo gemaakt voor de role: **s1199469/my-docker_role**
7. Inhoud van \my-docker gekopieerd naar de nieuwe repo
8. my-docker repo gepusht naar Github

# toevoegen aan ansible-galaxy

