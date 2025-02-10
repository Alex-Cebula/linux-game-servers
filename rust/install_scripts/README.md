# Debian Rust Server Installer

Bash based installation process for creating a server for the game Rust. This series of scripts handles installing required dependencies, steamcmd for linux, rust client and the creation of a linux service for the server.

## Structure

The structure of these files includes a single install script that references a number of supporting scripts.

### install.sh

Calls supporting scripts throughout the installation process.

### install_steamcmd.sh

Prepares and installs steamcmd. This will also install the **software-properties-common package**, the **32bit x86 architecture**, and the **non-free repository**.

### install_rust.sh

Creates a rust linux user and installs the rust client as that user. This will also prompt you for config information for the server and create a linux service for it.

### install_oxide.sh

This will handle downloading oxide and unziping it's contents into the rust server.

### update.sh

This will ensure the server is shutdown, update the rust client through steamcmd and call the install oxide script.

## Directions

1. Download this directory to a permanent or temporary location of your choosing.
2. cd into this directory.
3. Run the install script.

    ```bash
        bash install.sh
    ```

4. Acknowledge any prompts that appear during the installation process.
5. Start the server.

    ```bash
        systemctl start rustserver
    ```

6. That's it.

## Gotcha's

### Networking

Port forward your server port for both TCP and UDP. If your using a firewall, add bypass rules for the port for both TCP and UDP.

### SFTP

If you plan on using SFTP to transfer files to your Debian machine then ensure that your Debian kernal has ssh enabled and running. If you wish to login as root through ssh then you must permit root login for ssh.

Check that ssh is running.

```bash
    systemctl status ssh
```

Verify /etc/ssh/sshd_config has this value.

```txt
    PermitRootLogin yes
```

### Scheduling tasks

To schedule startups, shutdowns, restarts, updates etc, use a cronjob. You can alter cronjobs by using the following command.

```bash
    crontab -e
```

### RustServer Service Logs

Use the following command to read logs for the rustserver service.

```bash
    journalctl -u rustserver
```

### Interacting with RCON

I've found that the best way to use RCON is to get the **RustAdmin** app and enter RCON commands there.