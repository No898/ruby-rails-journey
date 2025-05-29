dnes jsem zacal s cvicenim exercism simple-calculator



poznamky
begin
...
rescue someError
...
end

je stejny jako try catch block

| JavaScript / TypeScript | Ruby                           |
| ----------------------- | ------------------------------ |
| `Error`                 | `StandardError`                |
| `TypeError`             | `TypeError` (v Ruby taky!)     |
| `RangeError`            | `RangeError`                   |
| **(vlastní třída)**     | `ArgumentError`, `CustomError` |

zjistil jsem, ze node.js tu je hlavne kvuli realtime aplikacim proti ruby a velky boom byl pred 15 lety kdyz zacli "frcet" realtime aplikace

rail pouziva actioncabel, ktere je vestaveny websocket v rails, ale je to vhodne max pro desitky uzivatelu a mensi appky, rozhodne ne pro robustnejsi system, kazdopadne tu je jeste SSE(server sent events), kde posila server data do klienta podle jakmile jsou data dostupna a pooling, kdy klient posila kazdych par sekund requesty na api 

| Metoda                       | Obousměrná? | Vhodné pro                    | Složitost  |
| ---------------------------- | ----------- | ----------------------------- | ---------- |
| ActionCable                  | ✅ Ano       | Chaty, notifikace, dashboardy | 🟨 Střední |
| Polling                      | ❌ Ne        | Základní dashboardy           | 🟩 Nízká   |
| Server-Sent Events           | ❌ Ne        | Logy, async job status        | 🟨 Střední |
