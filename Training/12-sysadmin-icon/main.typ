#import "@preview/polylux:0.3.1": *
#import themes.university: *
#show: university-theme.with(
  color-a: rgb("#006573"),
  color-b: rgb("#840052"),
)

#import "@preview/treet:0.1.1": *

#set page(paper: "presentation-16-9")
#set text(fill: rgb("#5a6973"), size: 24pt)

#title-slide(
  title: "SCC24 cluster security and administration with Ansible",
  authors: "Matias Zwinger",
  institution-name: "CSC",
  logo: [#pad(top: 8pt, right: 8pt, image("csc_logo.svg", width: 20%))],
)

#set quote(block: true)

#slide(new-section: "Security")[
  = Security
  #quote(attribution: [SCC24 Systems and Security Evaluation])[
    In interviews and any written documents, we want to see that you have and use plans, tools, best practices, and documentation to make it through the contest [...]
  ]
]

#slide[
  == Documentation
  - Write down how you use Ansible on the cluster
  - For full points: security plan and incident management
    - Wave your hands a little bit
  - Refer to standards
  - Use hackmd.io or something similar
    - Make it discoverable for team members
]

#set quote(block: false)

#slide[
  == Account management
  - No account sharing
  - Lock the root account
    - i. e. no one can `su root`
    - Use sudo
  - Don't give out sudo rights without reason
    - The sysadmins can install software dependencies
    - Or better yet, use Ansible to install them
  - Have strong password requirements
  - Change default passwords
  - Disable SSH password login
]

#slide[
  == Configuration management #sym.arrow Ansible
  - Do all system administration through Ansible
    - Ansible acts as documentation
  - #quote[+4 pts for being able to produce a configuration inventory showing the state of the cluster (and any deviations from planned configuration) on demand] \
    #sym.arrow `ansible-playbook` with `--check` and `--diff`
  - #quote[+2 pts for having different roles based on node function] \
    #sym.arrow CPU and GPU nodes in different subgroups
]

#slide[
  == Patching
  - Keep your software up to date
  - Install security patches if available
    - Just by doing patching you get +3 pts
  - Justify any outdated packages in the documentation
]

#slide[
  == Software management
  - Install all software using Ansible
  - Don't install anything unnecessary
    - Uninstall it if you don't need it
  - Install only from trusted sources
    - Package manager
    - Official git repo
    - Official website
      - calculate the checksum!
  - +3 pts for being able to list all packages installed
]

#slide[
  == Networking
  - Limit attack surface
    - Move SSH to a nonstandard port
      - Be careful to not lock yourself out
    - Install a firewall
      - May be already present on RHEL
  - Close management interfaces like IPMI
]

#slide[
  == Logging
  - Use a tool like Prometheus to centrally gather logs
  - Visualize the data with Grafana
  - Set up alerts for possible attacks
    - sshd access log
    - failed sudo attempts
]

#slide[
  = Communication with peers
  - #quote[+0.25 pt for each team to which you've worked out a way to communicate systems and security tips, tricks, and concerns and actually done so] \
    #sym.arrow share your knowledge
  - Act on the advice other teams give you
  - Report any security issues in the SCC infrastructure to staff
]

#slide[
  == Conclusion
  - The judges like standards
    - Justify as much as possible with standards
  - Read the whole list of criteria in the Systems and Security Evaluation PDF
    - Sent in the system administration TG chat
    - The appendix has useful links
  - Misconfigurations and compromises yield negative points
]

#focus-slide(background-color: white)[
  #align(center + horizon, image("ansible-logo.png"))
]

#slide(new-section: "Ansible")[
  = Ansible
  - Provisioning tool
  - Why not bash scripts?
    - Treat your infrastructure as code!

  == Example playbook:
  1. Make sure user `alice` and is in the groups `user` and `sudo`
  2. Install `git`, `vim` and `gcc` using `apt` if they are not installed
  3. Make sure a cronjob which runs `foo` every hour exists
]

#slide()[
  - Most actions are idempotent
    - Executing the same playbook 100 times *SHOULD* do the same thing as running it only once.
  - Example: The user `alice` exists already
    - Running the playbook again, Ansible will see that `alice` exists and is in the specified groups
    - Exits without modifying anything
]

#slide()[
  #text(size: 18pt)[
    ```yaml
    ---                     # Starts the document
    # List
    - item 1
    - item 2
    - item 3

    dict1:                  # Dictionary
      key1: value1          # Strings don't need quotation marks
      key2: |
        multi
        line
        string

    # List of dictionaries
    - subdict1:
      key1: true            # Boolean
    - subdict2:
      key1: no              # Same as false, but please don't do this
    ```
  ]
]

#slide[
  #text(size: 18pt)[
    ```yaml
    ---
    - name: Set up login node users # Names starting with upper case are the standard
      hosts: login-node             # Select which hosts to run on
      become: true                  # Run using superuser rights

      tasks:
        - name: Ensure user alice exists
          user:                     # Module name
            name: alice             #   <
            state: present          #   < Module arguments
            shell: /bin/bash        #   <
            groups: users,sudo      #   <

        - name: Install tools
          apt:
            pkg:
            - git
            - vim
            - gcc
    ```
  ]
]

#slide[
  == Running Ansbile playbooks
  - `ansible-playbook setup.yml`
  - Continue from task `foo` \
    `ansible-playbook setup.yml --start-at foo`
  - Dry run \
    `ansible-playbook setup.yml --check --diff`
  - Run only the tasks marked with tags `foo` and `bar` \
    `ansible-playbook setup.yml --tags foo,bar`

  #text(size: 18pt)[
    ```yaml
    - name: Do something
      tags:
        - foo
        - bar
      # [...]
    ```
  ]
]

#matrix-slide[
  #text(size: 18pt)[
    == `setup.yml`
    ```yaml
    ---
    - name: Set up login node users
      hosts: login-node
      become: true
      roles:
        - setup
    ```
  ]
][
  #text(size: 18pt)[
    == `roles/setup/tasks/main.yml`
    ```yaml
    ---
    - name: Ensure user alice exists
      user:
        name: alice
        state: present
        shell: /bin/bash
        groups: users,sudo

    - name: Install tools
      apt:
        pkg:
        - git
        - vim
        - gcc
    ```
  ]
]

#slide[
  #text(
    font: "Cascadia Code",
    size: 15pt,
    tree-list[
      - ansible.cfg
      - inventory
        - hosts.yml
      - setup.yml
      - slurm.yml
      - hpl.yml
      - etc.
      - roles
        - slurm
          - defaults
            - main.yml
          - files
            - install.sh
          - tasks
            - main.yml
        - hpl
          - tasks
          - ...
        - etc.
    ],
  )
]

#slide[
  #text(size: 18pt)[
    ```yaml
    all:
      hosts:
        login-node:
          ansible_host: 1.3.3.7
          ansible_user: sysadmin

      children:
        compute-nodes:
          hosts:
            compute-node-01:
              ansible_host: 10.0.0.1
              ansible_user: root
              ansible_ssh_common_args: '-o ProxyCommand="ssh -W %h:%p -q sysadmin@1.3.3.7"'
            compute-node-02:
              ansible_host: 10.0.0.2
              ansible_user: root
              ansible_ssh_common_args: '-o ProxyCommand="ssh -W %h:%p -q sysadmin@1.3.3.7"'
    ```
  ]
]

#slide[
  == Using Ansible for controlling compute nodes
  - Ping all compute nodes\
    `ansible compute-nodes -m ping`
  - Run a command `foo` on all compute nodes \
    `ansible compute-nodes -m command -a 'foo'`
  - Reboot all compute nodes \
    `ansible compute-nodes --become --ask-become-pass -m command -a 'reboot now'`
]

#focus-slide(background-color: rgb("#006573"))[
  #link("https://github.com/mk3z/scc24-ansible")[
    #text(font: "Cascadia Code", size: 32pt)[
      #align(center)[github.com/mk3z/scc24-ansible]
    ]
  ]
]

