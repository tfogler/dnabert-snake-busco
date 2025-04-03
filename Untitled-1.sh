git clone https://github.com/ggml-org/llama.cpp

cd llama.cpp

snap install cmake --classic

cmake -B build -DGGML_CUDA=ON
cmake --build build --config Release -j $(nproc)

huggingface.co/unsloth/DeepSeek-v3-GGUF

wget https://huggingface.co/unsloth/DeepSeek-V3-GGUF/resolve/main/DeepSeek-V3-Q2_K_XS/DeepSeek-V3-Q2_K_XS-00001-of-00005.gguf?download=true
wget https://huggingface.co/unsloth/DeepSeek-V3-GGUF/resolve/main/DeepSeek-V3-Q2_K_XS/DeepSeek-V3-Q2_K_XS-00002-of-00005.gguf?download=true
wget https://huggingface.co/unsloth/DeepSeek-V3-GGUF/resolve/main/DeepSeek-V3-Q2_K_XS/DeepSeek-V3-Q2_K_XS-00003-of-00005.gguf?download=true
wget https://huggingface.co/unsloth/DeepSeek-V3-GGUF/resolve/main/DeepSeek-V3-Q2_K_XS/DeepSeek-V3-Q2_K_XS-00004-of-00005.gguf?download=true
wget https://huggingface.co/unsloth/DeepSeek-V3-GGUF/resolve/main/DeepSeek-V3-Q2_K_XS/DeepSeek-V3-Q2_K_XS-00005-of-00005.gguf?download=true

./llama-cli \
--model DeepSeek-V3-Q2_K_XS-00001-of-00005.gguf \
--cache-type-k q5_0 \
--threads 16 \
--prompt '<｜User｜>What is 1+1?<｜Assistant｜>'

'<|User|>Can you create a data table summarizing features of the following plant species, giving their Plant Type	Lifestyle	Lifespan	Geographical Distribution &	Habitat \
<|Assistant|>\
<|User|>\
| Species name | Common name |\
| Viscum album | European mistletoe |\
| Pinus tabuliformis | southern Chinese pine |\
| Helianthus tuberosus | Jerusalem artichoke |\
| Agapanthus africanus | African lily |\
| Torreya grandis | Chinese nutmeg-yew |\
<|Assistant|>'