# ilo4_unlock (Silence of the Fans)
A toolkit for patching HPE's iLO 4 firmware with access to previously inaccessible utilities.

Specifically, firmware is patched with the ability to access new commands via SSH, relating to system health (`h`), fan tuning (`fan`), on-board temperature sensors (`ocsd`), and option chip health systems (`ocbb`). Designed for [/r/homelab](https://reddit.com/r/homelab) users, this modified firmware provides administrators with the ability to adjust HP's aggressive fan curves on iLO4-equipped servers (such as DL380p / DL380p Gen 8 & Gen 9). Another common use case is to prevent server fans from maxing out when a non-HPE certified PCI-e card is used in a system.

## Legal
There is risk for potential damage to your system when utilizing this code. If an error occurs during flashing, or you end up flashing corrupted firmware, the iLO will not be able to recover itself. The iLO's flash chip cannot be programmed on-board, and must be fully desoldered and reprogrammed to recover the functionality. Additionally, utilizing the included new features may cause your server to overheat or otherwise suffer damage. Do not proceed with installing this firmware if you don't know what you're doing. **You have been warned**. There is no warranty for this code nor will I be responsible for any damage you cause. I have personally only tested this firmware on my DL380p Gen8, and DL380e Gen8.

This repo does not contain any iLO 4 binaries; unmodified or patched as they are owned by HP. For security purposes, I encourage you to follow the steps listed to build the patched version of the iLO yourself, while verifying the contents of the patched code.

## Getting Started

## Installation

## Use

## Credits
- Thanks to the work of [Airbus Security Lab](https://github.com/airbus-seclab/ilo4_toolbox); whose previous work exploring iLO 4 & 5 was instrumental in allowing the development of modified iLO firmware.
- And to [/u/phoenixdev](https://www.reddit.com/user/phoenixdev), whose original work on iLO4 v2.60 and v2.73 allowed for fans to be controlled in the first place.
This repository utilizes modified code from the iLO4 Toolbox. The toolkit invokes code directly from the iLO4 Toolbox, as well as includes modified versions of Airbus Security Lab's original patching code to perform the necessary patches. It also utilizes code originally written by [/u/phoenixdev](https://www.reddit.com/user/phoenixdev) that was reverse-engineered from their patched v2.73 iLO4 firmware.

The full documentation on how this code base was derived is fully detailed [in the research/ folder](https://github.com/kendallgoto/ilo4_unlock/tree/master/research).

## Relevant Reading & Prior Work
[2019-10-02 /u/phoenixdev's preliminary writeup](https://www.reddit.com/r/homelab/comments/dc7dbc/silence_of_the_fans_preliminary_success_with/)  
[2019-10-15 /u/phoenixdev's first release for v2.60](https://www.reddit.com/r/homelab/comments/di3vrk/silence_of_the_fans_controlling_hp_server_fans/)  
[2020-06-30 /u/phoenixdev's second release for v2.73](https://www.reddit.com/r/homelab/comments/di3vrk/silence_of_the_fans_controlling_hp_server_fans/)  
[Airbus Security Lab's iLO4 Toolbox](https://github.com/airbus-seclab/ilo4_toolbox)  
[Airbus Security Lab's "Subverting your server through its BMC: the HPE iLO4 case" (written version)](https://airbus-seclab.github.io/ilo/SSTIC2018-Article-subverting_your_server_through_its_bmc_the_hpe_ilo4_case-gazet_perigaud_czarny.pdf)  
[Airbus Security Lab's "Subverting your server through its BMC: the HPE iLO4 case" (presented version)](https://airbus-seclab.github.io/ilo/RECONBRX2018-Slides-Subverting_your_server_through_its_BMC_the_HPE_iLO4_case-perigaud-gazet-czarny.pdf)  