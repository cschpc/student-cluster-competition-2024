# SCC24 Interviews in competition

## Benchmarks

### HPL

Hex: asked about how we optimized our benchmarking. I think Sara and Camilla answered that we use the rocHPL distribution, and that we run the benchmark with different parameters to optimize. Vaguely remember maybe I said that we changed libfabric for ucx during that, for it was either the HPL interview or ICON.

### MLPerf

Hex: I remember being asked about what is the biggest challenge we face. I answered it's the cm4mlops tool, that it's poorly documented and causes irreproducible building and running, and the fact that we have AMD GPUs which doesn't perform the best when it comes to machine learning... One thing worth mentioning is that the tool actually failed to create submission data. asked the judges about this and they told me to create an [issue](https://github.com/mlcommons/cm4mlperf-inference/issues/77) when there's only half an hour left in the benchmarking period.

## ICON

Hex: they asked about our dedicated IO threads at one point. I was under high stress at that point, unsure of other questions asked... We had a decent full-cluster run going when there are 5 hours left in the competition, but I got this error 1.5hr into the run, something about "L2 pagefault", I can tell it's from amdgpu because we have been getting them from time to time according to dmesg. I asked (in a complaining tone) the judges if they have seen this sort of error before, they said no then provided some uninsightful suggestions.

## NAMD

## Systems

Hex: during the benchmark period, nonformal interview about where we store our documentation, when was the last time we patched our software stack etc. asked about configuration management, answered we had Ansible. asked if we changed all of our passwords, mentioned iLO, talked about having out-of-band management VLAN and whatnot. asked about incidence response plan, I asked them to clarify what was expected, the answer was vague, from "what if team member is compromised" moved onto "who to contact when system issues are encountered". Mentioned centralized logging, replied we're installing rsyslogd (postponed indefinitely)... wednesday afternoon formal interview conducted. less questions asked. first asked about the cluster overall, answered hardware. asked about if we had infiniband and where we run the subnet manager (we had opensm running on the first node.) asked specifically about how sudo access given, if there is a review process or formal procedure, to which I answered negatively. One more mention of VLAN. I described our firewall setup (which imo was pretty cool) but William and the other judge seems to be not too interested in.

## Mystery

Hex: they asked us to have a presentation about our solution. Matteo presented our choice of framework theoretically. little feedback was given, except to assure us that it's "more about finding the right combination" than bruteforcing... asked about what gpu we have iirc.

## Other notes

### Scavenger Hunt

Hex: for context, there was this scavenger hunt card with ~40 stamps we had to collect. It was counted towards final points. althought I had fun hanging around the convention center, it was physically exhausting. the vendor booth list was written in riddles, some doesn't make any sense, while sometimes the vendor staff insists that you answer the riddle so that they give you the stamp. Supermicro was particularly offensive, because when I asked another staff in their booth, they had no idea how to answer their own riddle either. I was on the verge of becoming confrontational, as they were literally wasting our time. I have to point out that this feels like a rather distasteful assignment to give to a non-native speaker of English, oh well...
