Ispisuje sve predviđene nestanke struje HEP-a za slijedećih par dana u
kalendaru koji matchiraju zadani regex za zadano distribucijsko područje.

Podaci su dobiveni parsiranjem http://www.hep.hr/ods/dp/nestanak.aspx

Pozivanje scripte iz crona omogućava se jednostavno obaviještavanje o nestancima
električne energije za koje smo zainteresirani.

Usage: $0 <ELEKTRA_PODRUCJE> <ELEKTRA_POGON> <REGEXP>

ELEKTRA_PODRUCJE: distribucijsko podrucje (grad) iz dropdown liste (HTML select value) na http://www.hep.hr/ods/dp/nestanak.aspx
 (npr. "rijeka" za "Elektroprimorje Rijeka", "zagreb" za "Elektra Zagreb" itd)

ELEKTRA_POGON: odabir pogona ili elektre unutar navednog podrucja 
 (npr. unutar DP Zagreb su "ZG" = "Elektra Zagreb", "177" = "Elektra Zaprešić", "114" = "Elektra Velika Gorica"...)

REGEXP: case independent regular expression koji će matchirati naziv ulice (npr. 'Savska'; ili 'Ti.+ari.+ka' za "Tičarićka ulica")
