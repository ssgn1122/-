<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>전쟁군주 아베르지안 작전 지침서</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap');

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #020617;
            color: #e2e8f0;
        }

        .void-cell {
            transition: all 0.2s ease-in-out;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .void-occupied {
            background: radial-gradient(circle, #4c1d95 0%, #1e1b4b 100%);
            box-shadow: 0 0 20px rgba(139, 92, 246, 0.4);
            border-color: #8b5cf6 !important;
        }

        .void-occupied::after {
            content: '점령 완료';
            font-size: 0.75rem;
            font-weight: bold;
            color: #ddd6fe;
            position: absolute;
            bottom: 10px;
        }

        .cosmic-shell {
            border-color: #facc15 !important;
            background: rgba(250, 204, 21, 0.05);
        }

        .shell-indicator {
            position: absolute;
            top: 6px;
            right: 6px;
            background: #facc15;
            color: #000;
            font-size: 9px;
            font-weight: 900;
            padding: 1px 4px;
            border-radius: 3px;
            z-index: 10;
        }

        .gather-point {
            position: absolute;
            width: 38px;
            height: 38px;
            background: rgba(34, 197, 94, 0.7);
            border: 2px solid #4ade80;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 8px;
            font-weight: bold;
            color: white;
            animation: pulse-green 1.5s infinite;
            z-index: 20;
            pointer-events: none;
        }

        @keyframes pulse-green {
            0% {
                transform: scale(0.9);
                opacity: 0.6;
            }

            50% {
                transform: scale(1.1);
                opacity: 0.9;
            }

            100% {
                transform: scale(0.9);
                opacity: 0.6;
            }
        }

        @keyframes pulse-red {

            0%,
            100% {
                border-color: #ef4444;
                box-shadow: 0 0 15px rgba(239, 68, 68, 0.4);
            }

            50% {
                border-color: #991b1b;
                box-shadow: 0 0 30px rgba(239, 68, 68, 0.7);
            }
        }
    </style>
</head>

<body class="p-4 md:p-8">
    <div class="max-w-md mx-auto bg-slate-900 border border-slate-800 rounded-3xl p-6 shadow-2xl">
        <!-- 헤더 -->
        <div class="flex justify-between items-start mb-6">
            <div>
                <h1 class="text-xl font-bold text-indigo-400">전쟁군주 아베르지안 작전 지침</h1>
                <p class="text-[10px] text-slate-500 mt-1 uppercase tracking-tighter">Tactical Command System v3.0</p>
            </div>
            <div id="diff-tag"
                class="px-2 py-1 bg-slate-800 rounded text-[10px] font-bold text-slate-400 border border-slate-700">
                NORMAL
            </div>
        </div>

        <!-- 난이도 선택 -->
        <div class="grid grid-cols-3 gap-2 mb-6">
            <button onclick="setDifficulty('normal')" id="btn-normal"
                class="py-2 text-xs font-bold rounded-xl bg-indigo-600 text-white border border-indigo-500">일반</button>
            <button onclick="setDifficulty('heroic')" id="btn-heroic"
                class="py-2 text-xs font-bold rounded-lg bg-slate-800 text-slate-400 border border-slate-700">영웅</button>
            <button onclick="setDifficulty('mythic')" id="btn-mythic"
                class="py-2 text-xs font-bold rounded-lg bg-slate-800 text-slate-400 border border-slate-700">신화</button>
        </div>

        <!-- 그리드 -->
        <div id="grid-container" class="grid grid-cols-3 gap-2 aspect-square mb-6 relative">
            <!-- JS -->
        </div>

        <!-- 상태 메시지 -->
        <div class="bg-slate-950 rounded-xl p-4 border border-slate-800 mb-6">
            <div id="instruction" class="text-sm font-medium text-indigo-300 text-center">
                점령 구역을 선택하십시오.
            </div>
        </div>

        <!-- 주의사항 및 가중치 가이드 (복구됨) -->
        <div class="bg-slate-950 rounded-xl p-4 border border-indigo-900/30 mb-6 text-[11px] leading-relaxed">
            <div class="mb-3">
                <p class="text-indigo-400 font-bold mb-1 underline underline-offset-4">알고리즘 기반 가중치 분석</p>
                <div class="grid grid-cols-3 gap-1 text-center mt-2">
                    <div class="p-1 bg-red-950/30 border border-red-900/50 rounded text-red-300">중앙: 가중치 4</div>
                    <div class="p-1 bg-orange-950/30 border border-orange-900/50 rounded text-orange-300">모서리: 가중치 3
                    </div>
                    <div class="p-1 bg-blue-950/30 border border-blue-900/50 rounded text-blue-300">변: 가중치 2</div>
                </div>
            </div>

            <div class="space-y-2">
                <p class="text-slate-400"><strong class="text-slate-200">1. 이격 주차:</strong> 보스와 하수인은 반드시 <span
                        class="text-yellow-500">10m 이상</span> 떨어뜨려야 합니다.</p>
                <p class="text-slate-400"><strong class="text-slate-200">2. 빙고 방지:</strong> 가로, 세로, 대각선 중 한 줄이 완성되면
                    <span class="text-red-500 font-bold">광포화</span>가 발동합니다.</p>
                <div id="heroic-notes" class="hidden">
                    <p class="text-green-400 font-bold border-t border-slate-800 pt-2 mt-2">영웅 난이도 추가 지침:</p>
                    <p class="text-slate-400">• <span class="text-green-400">본진 집결(G):</span> 구체자 파괴 시 녹색 원 위치에 뭉쳐서 빔
                        피해를 분담하십시오.</p>
                </div>
                <div id="mythic-notes" class="hidden">
                    <p class="text-yellow-400 font-bold border-t border-slate-800 pt-2 mt-2">신화 난이도 추가 지침:</p>
                    <p class="text-slate-400">• <span class="text-yellow-400">우주의 껍질:</span> 징표 대상자 해제를 통해 보호막 중첩(S)을
                        제거해야 점령이 가능합니다.</p>
                </div>
            </div>
        </div>

        <!-- 컨트롤 -->
        <div class="flex gap-2">
            <button onclick="resetAll()"
                class="flex-1 py-3 bg-slate-800 hover:bg-slate-700 rounded-xl text-sm font-bold">초기화</button>
            <button onclick="copyTactics()"
                class="flex-1 py-3 bg-indigo-900 hover:bg-indigo-800 rounded-xl text-sm font-bold">전술 복사</button>
        </div>
    </div>

    <!-- 빙고 레이어 -->
    <div id="alert-layer" class="fixed inset-0 bg-red-950/95 flex flex-col items-center justify-center z-50 hidden">
        <div class="text-center p-8">
            <h2 class="text-4xl font-black text-white mb-2">끝없는 행진</h2>
            <p class="text-red-300 mb-8 tracking-widest text-sm font-bold">전멸 기믹 발동</p>
            <button onclick="resetAll()" class="px-10 py-4 bg-white text-red-900 rounded-full font-bold">재시작</button>
        </div>
    </div>

    <script>
        const container = document.getElementById('grid-container');
        const instruction = document.getElementById('instruction');
        const heroicNotes = document.getElementById('heroic-notes');
        const mythicNotes = document.getElementById('mythic-notes');
        const diffTag = document.getElementById('diff-tag');
        const overlay = document.getElementById('alert-layer');

        let currentDiff = 'normal';
        let cells = Array(9).fill(null).map(() => ({ occupied: false, shell: 0 }));

        function setDifficulty(d) {
            currentDiff = d;
            ['normal', 'heroic', 'mythic'].forEach(mode => {
                const btn = document.getElementById(`btn-${mode}`);
                btn.className = mode === d ?
                    `py-2 text-xs font-bold rounded-xl ${mode === 'mythic' ? 'bg-yellow-600 border-yellow-500' : 'bg-indigo-600 border-indigo-500'} text-white border` :
                    "py-2 text-xs font-bold rounded-lg bg-slate-800 text-slate-400 border border-slate-700";
            });

            diffTag.innerText = d.toUpperCase();
            diffTag.className = `px-2 py-1 rounded text-[10px] font-bold border ${d === 'mythic' ? 'bg-yellow-950 border-yellow-600 text-yellow-500' : 'bg-slate-800 border-slate-700 text-slate-400'}`;

            heroicNotes.classList.toggle('hidden', d !== 'heroic');
            mythicNotes.classList.toggle('hidden', d !== 'mythic');
            resetAll();
        }

        function createGrid() {
            container.innerHTML = '';
            cells.forEach((cell, i) => {
                const div = document.createElement('div');
                div.className = `void-cell bg-slate-950 border-2 border-slate-800 rounded-2xl flex items-center justify-center ${cell.occupied ? 'void-occupied' : ''} ${currentDiff === 'mythic' && cell.shell > 0 ? 'cosmic-shell' : ''}`;
                div.innerHTML = `<span class="text-slate-700 font-bold text-xl">${i + 1}</span>`;

                if (currentDiff === 'mythic' && cell.shell > 0) {
                    div.innerHTML += `<span class="shell-indicator">S:${cell.shell}</span>`;
                }

                if (currentDiff === 'heroic' && !cell.occupied) {
                    const gather = document.createElement('div');
                    gather.className = "gather-point";
                    gather.innerText = "G";
                    div.appendChild(gather);
                }

                div.onclick = () => handleAction(i);
                container.appendChild(div);
            });
        }

        function handleAction(i) {
            const cell = cells[i];
            if (currentDiff === 'mythic' && !cell.occupied && cell.shell > 0) {
                cell.shell--;
                instruction.innerText = `${i + 1}번 보호막 약화 중 (${cell.shell}/2)`;
            } else {
                cell.occupied = !cell.occupied;
                instruction.innerText = cell.occupied ? `${i + 1}번 구역 점령` : `점령 해제`;
            }
            checkBingo();
            createGrid();
        }

        function checkBingo() {
            const lines = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]];
            if (lines.some(line => line.every(idx => cells[idx].occupied))) overlay.classList.remove('hidden');
        }

        function resetAll() {
            cells = Array(9).fill(null).map(() => ({ occupied: false, shell: currentDiff === 'mythic' ? 2 : 0 }));
            instruction.innerText = "구역을 선택하여 점령을 표시하십시오.";
            overlay.classList.add('hidden');
            createGrid();
        }

        function copyTactics() {
            const list = cells.map((c, i) => c.occupied ? i + 1 : null).filter(n => n).join(', ');
            const text = `[작전 데이터] 난이도: ${currentDiff.toUpperCase()} / 점령지: ${list || '없음'}`;
            const t = document.createElement("textarea");
            document.body.appendChild(t); t.value = text; t.select();
            document.execCommand('copy'); document.body.removeChild(t);
            const prev = instruction.innerText; instruction.innerText = "데이터가 복사되었습니다.";
            setTimeout(() => instruction.innerText = prev, 1500);
        }

        createGrid();
    </script>
</body>

</html>