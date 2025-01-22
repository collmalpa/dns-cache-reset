# DNS Cache Reset Script

This script is designed to reset the DNS cache on Linux systems running `systemd-resolved` as the DNS service. It ensures that the DNS service is installed, running, and then proceeds to clear the DNS cache. The script also checks the current DNS settings after the reset.

## Features
- **Root Privileges Check:** The script checks if it is run with root privileges.
- **Service Status Check:** Verifies that the `systemd-resolved` service is installed and running.
- **DNS Cache Reset:** Resets the DNS cache by restarting the DNS service.
- **Current DNS Settings:** Displays the current DNS settings using `resolvectl`.

## Prerequisites
- Linux-based system with `systemd-resolved` as the DNS service.
- The `resolvectl` command should be available for fetching DNS settings.

## Usage

1. Clone or download this repository to your local machine.

    ```bash
    git clone https://github.com/collmalpa/dns-cache-reset.git
    cd dns-cache-reset
    ```

2. Make the script executable.

    ```bash
    chmod +x reset_dns_cache.sh
    ```

3. Run the script as root to reset the DNS cache.

    ```bash
    sudo ./reset_dns_cache.sh
    ```

    The script will:
    - Check for root privileges.
    - Verify that the `systemd-resolved` service is installed and running.
    - Restart the service to reset the DNS cache.
    - Display the current DNS settings.

### Create an Alias for Easier Execution

To make running the script simpler, you can create an alias for it. Add the following line to your `.bashrc` or `.zshrc` file:

```bash
alias resetdns='sudo /path/to/reset_dns_cache.sh'
```

After adding the alias, run `source ~/.bashrc` or `source ~/.zshrc` to apply the changes. Now, you can simply run `resetdns` from the terminal.

## Example Output

When the script is run, the output may look something like this:

```bash
Checking if the systemd-resolved service is installed...
The systemd-resolved service is installed.
Checking if the systemd-resolved service is running...
The systemd-resolved service is running.
Resetting the DNS cache...
DNS cache successfully reset.
Fetching current DNS settings...
DNS Servers:
  127.0.0.53
  8.8.8.8
  8.8.4.4
DNS cache reset process completed.
```

## Troubleshooting

- If the `systemd-resolved` service is not installed or running, the script will attempt to start it. If it fails, ensure that your system has the correct DNS service installed.
- If the `resolvectl` command is not available, ensure that `systemd-resolved` is properly configured on your system.

## License

This script is open-source and distributed under the [MIT License](LICENSE).
```